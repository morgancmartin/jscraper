# Retrieves Job Postings from Indeed
class IndeedScraper
  attr_accessor :options
  def initialize(options = nil)
    @agent = Mechanize.new
    @page = @agent.get(construct_query_string(options)) if options
  end

  def options=(options)
    @options = options
    reset_page
  end

  def create_post(posting)
    date = retrieve_post_date(posting)
    if date && date > 1.day.ago
      Post.create(
        title: retrieve_post_title(posting),
        url: retrieve_post_url(posting),
        company: retrieve_company_name(posting),
        city: @options[:city],
        state: @options[:state],
        post_date: retrieve_post_date(posting)
      )
    end
  end

  def run
    postings.each do |posting|
      ap create_post(posting)
    end
  end

  def all_postings
    @page.search('.row.result')
  end

  def postings
    all_postings.select do |p|
      non_sponsored_posting?(p)
    end
  end

  def reset_page
    @page = @agent.get(construct_query_string(options))
  end

  def construct_query_string(options)
    options = @options || options
    search_term = options[:search_term].split(' ').join('+')
    location = options[:city] + ', ' + options[:state]
    location = location.split(',').join('%2C').split.join('+')
    "http://www.indeed.com/jobs?q=#{search_term}&l=#{location}&radius=100"
  end

  def retrieve_post_title(post)
    post.search('h2.jobtitle').search('a.turnstileLink').first['title']
  end

  def retrieve_post_date(post)
    allowed_units = %w[ day days hour hours week weeks]
    terms = post.search('span.date').children[0].content.strip.split(' ')
    num = terms[0].to_i
    unit = terms[1]
    if (allowed_units.include?(unit))
      return num.send(unit).ago
    end
    false
  end

  def retrieve_company_name(post)
    post.search('span.company').search('span.company')
        .search('span').children[1].content.strip
  end

  def retrieve_post_url(post)
    'http://www.indeed.com' + post
                       .search('h2.jobtitle')
                       .search('a.turnstileLink')
                       .first[:href]
  end

  def non_sponsored_posting?(posting)
    if posting[:id]
      posting[:id][0..1] == 'p_' 
    else
      false
    end
  end

  def sponsored_posting?(posting)
    posting[:id][0..1] == 'pj'
  end

  def titles
    postings.map do |post|
      retrieve_post_title(post)
    end
  end

  def urls
    postings.map do |post|
      retrieve_post_url(post)
    end
  end
end

## .search('div.result').search('h2.jobtitle')
## Regular posts = 'div.result' ->
# 'h2.jobtitle' ->
# 'a.turnstileLink'.first['title]
