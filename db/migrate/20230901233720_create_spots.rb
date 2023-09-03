class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.float :lat
      t.float :lng
      t.string :name

      t.timestamps
    end
  end
end
