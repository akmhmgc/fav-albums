class MyList < ApplicationRecord
  mount_uploader :image, ImageUploader
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)
  has_many :artists, dependent: :destroy

  validates :nickname,  presence: true, length: { maximum: 10 }

  def to_param
    public_uid
  end
end
