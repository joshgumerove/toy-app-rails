# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user #  means that Microposts will get a foreign key
  default_scope -> { order(created_at: :desc) } # orders the posts starting with the newest (note the syntax)
  validates :content, length: { maximum: 140 }, presence: true
  validates :user_id, presence: true
  # NOTE: this comes from active storage and allows us to attach images
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, 500]
  end
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size:
                          { less_than: 5.megabytes,
                            message:
                          'should be less than 5MB' }

  # def display_image
  #     image.variant(resize_to_limit: [500, 500])
  # end
end
