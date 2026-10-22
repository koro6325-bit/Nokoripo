class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount
      t.string :memo
      t.date :date

      t.timestamps
    end
  end
end
