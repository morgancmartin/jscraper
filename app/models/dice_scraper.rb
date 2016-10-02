# Retrieves Job Postings from Dice
class DiceScraper
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
    @page.search('.serp-result-content')
  end

  def postings
    all_postings
  end

  def reset_page
    @page = @agent.get(construct_query_string(options))
  end

  def construct_query_string(options)
    options = @options || options
    search_term = options[:search_term].split(' ').join('_')
    location = options[:city] + ', ' + options[:state]
    location = location.split(',').join('%2C').split.join('_')
    "https://www.dice.com/jobs/q-#{search_term}-l-#{location}-radius-100-jobs.html"
  end

  def retrieve_post_title(post)
    post.search('h3 a.dice-btn-link').first['title']
  end

  def retrieve_post_date(post)
    allowed_units = %w[ day days hour hours week weeks]
    terms = post.search('li.posted').text.split
    num = terms[0].to_i
    unit = terms[1]
    if (allowed_units.include?(unit))
      return num.send(unit).ago
    end
    false
  end

  def retrieve_company_name(post)
    post.search('li.employer a.dice-btn-link').text
  end

#https://www.dice.com/jobs/detail/Full-Stack-Developer-3Ci-Alpharetta-GA-30022/comga001/16816TKF?icid=sr1-1p&q=Full%20Stack%20Developer&l=Alpharetta,%20GA
  def retrieve_post_url(post)
    post.search('a.dice-btn-link').first['href']
  end

  # def non_sponsored_posting?(posting)
  # end

  # def sponsored_posting?(posting)
  # end
end


