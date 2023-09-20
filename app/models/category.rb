class Category < ActiveHash::Base
  self.data = [
    {id:1, name: '---'},
    {id:2, name: '農園'},
    {id:3, name: '産直店'},
    {id:4, name: '園芸店'},
    {id:5, name: 'レストラン'}
  ]

  include ActiveHash::Associations
  has_many :spots

end