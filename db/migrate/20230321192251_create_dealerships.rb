class CreateDealerships < ActiveRecord::Migration[5.2]
  def change
    create_table :dealerships do |t|
      t.string :name
      t.boolean :financing_available
      t.integer :employees
      t.timestamps
    end
  end
end
