class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.references :product, foreign_key: true, null: false
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
