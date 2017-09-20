class Photo < ApplicationRecord
  mount_uploader :name, ImageUploader
  validates :name, presence: true

  before_validation :validate_size

  def validate_size
    if name.size > 2.megabytes
      errors.add(:base, "图片大小不能超过2MB")
    end
  end

end
