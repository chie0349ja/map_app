class Spot < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :photo
  belongs_to :category, class_name: 'Category'
  validates :lat, :lng, :name, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 
end
