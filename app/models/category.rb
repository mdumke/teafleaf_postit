class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  after_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.gsub(" ", "-").downcase
  end
end
