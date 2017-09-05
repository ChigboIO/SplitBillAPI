class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.references :creator, foreign_key: { to_table: 'users' }
      t.integer :amount
      t.string :title
      t.text :description
      t.timestamp :date
      t.text :splitters

      t.timestamps
    end
  end
end
