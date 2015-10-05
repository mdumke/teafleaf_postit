class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :create

  after_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    base_slug = to_slug(username)
    user = User.find_by_slug(base_slug)

    count = 2
    current_slug = base_slug

    while user && user != self
      current_slug = base_slug + "-#{count}"

      user = User.find_by_slug(current_slug)
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
