class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  after_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    base_slug = to_slug(name)
    category = Category.find_by_slug(base_slug)

    count = 2
    current_slug = base_slug

    while category && category != self
      current_slug = base_slug + "-#{count}"

      category = Category.find_by_slug(current_slug)
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
