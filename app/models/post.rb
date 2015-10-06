class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true

  before_save :generate_slug

  def to_param
    slug
  end

  def generate_slug
    base_slug = to_slug(title)
    post = Post.find_by_slug(base_slug)

    count = 2
    current_slug = base_slug

    while post && post != self
      current_slug = base_slug + "-#{count}"

      post = Post.find_by_slug(current_slug)
      count += 1
    end

    self.slug = current_slug
  end

  def to_slug(str)
    str.strip
      .gsub(/\s*[^A-Za-y0-9]\s*/, '-')
      .gsub(/-+/, '-')
      .downcase
  end
end
