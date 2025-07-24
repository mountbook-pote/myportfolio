class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 10 }

  # ゲストユーザ用のコード
  GUEST_USER_EMAIL = 'guest@example.com'.freeze
  GUEST_USER_NAME = 'ゲスト'.freeze

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.name = GUEST_USER_NAME
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def guest?
    email == GUEST_USER_EMAIL
  end

  # アイコン画像用のコード
  has_one_attached :image
  validate :image_content_type
  validate :image_size

  private 
  def image_content_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
    end
  end

  def image_size
    if image.attached? && image.blob.byte_size > 1.megabytes
      errors.add(:image, '：1MB以下のファイルをアップロードしてください。')
    end
  end
end
