class CreateSplits < ActiveRecord::Migration[5.1]
  def change
    create_table :splits do |t|
      t.references :payer, foreign_key: { to_table: 'users' }
      t.references :bill, foreign_key: true
      t.integer :amount
      t.string :comment
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
