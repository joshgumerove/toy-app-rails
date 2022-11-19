# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user #  means that Microposts will get a foreign key
  default_scope -> { order(created_at: :desc) } # orders the posts starting with the newest (note the syntax)
  validates :content, length: { maximum: 140 }, presence: true
  validates :user_id, presence: true
end
