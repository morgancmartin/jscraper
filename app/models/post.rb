class Post < ApplicationRecord
  validates :url, uniqueness: true

  def self.where_within_num_days(num)
    where('post_date > ?', num.day.ago)
  end

  def self.where_title_ilike_term(term)
    where("lower(title) ILIKE '%#{term.downcase}%'")
  end

  def self.junior
    self.where_title_ilike_term('junior')
  end

  def self.ruby
    self.where_title_ilike_term('ruby')
  end

  def self.rails
    self.where_title_ilike_term('rails')
  end

  def self.one_day
    self.where_within_num_days(1)
  end
end
