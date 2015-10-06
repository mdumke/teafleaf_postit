module Sluggable
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug
    class_attribute :slug_column
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

  def to_param
    slug
  end

  def generate_slug
    the_slug = self.send(self.class.slug_column.to_sym)
    return unless the_slug

    base_slug = to_slug(the_slug)

    obj = self.class.find_by_slug(base_slug)

    count = 2
    current_slug = base_slug

    while obj && obj != self
      current_slug = base_slug + "-#{count}"

      obj = self.class.find_by_slug(current_slug)
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
