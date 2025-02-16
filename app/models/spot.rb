class Spot < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :photo
  belongs_to :user
  belongs_to :category, class_name: 'Category'
  validates :lat, :lng, :name, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 
  before_validation :resize_photo

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "lat", "lng", "name", "spots_url", "updated_at", "user_id", "value"]
  end

  private
  def resize_photo
    return unless photo.attached?
  
    begin
      # アップロードされた画像を取得
      image = MiniMagick::Image.read(photo.download)
      image.resize "300x300"
  
      # 元の画像を削除し、新しいリサイズ済みの画像を保存
      photo.attach(
        io: StringIO.new(image.to_blob),
        filename: photo.filename.to_s,
        content_type: photo.content_type
      )
    rescue StandardError => e
      Rails.logger.error "Image resizing failed: #{e.message}"
    end
  end

end
