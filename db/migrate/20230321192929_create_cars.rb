class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.references :dealership, foreign_key: true
      t.string :make
      t.string :model
      t.boolean :awd
      t.integer :mileage
      t.timestamps
    end
  end
end
