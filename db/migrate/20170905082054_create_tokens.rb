class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.references :user, foreign_key: true
      t.text :value
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
