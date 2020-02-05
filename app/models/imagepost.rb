# frozen_string_literal: true

class Imagepost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # mount_uploader :avatar, AvatarUploader
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 2000 }
  validate  :picture_size
    # attr_accessor :avatar

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end
end
