class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.float :lat
      t.float :lng
      t.string :name
      t.integer :category_id
      t.text :spots_url     #URLがあればここに記載
      t.string :value       #育てている野菜の種類など
      t.timestamps
    end
  end
end
