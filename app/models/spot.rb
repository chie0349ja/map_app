class Spot < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :photo
  belongs_to :user
  belongs_to :category, class_name: 'Category'
  validates :lat, :lng, :name, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "lat", "lng", "name", "spots_url", "updated_at", "user_id", "value"]
  end

end
