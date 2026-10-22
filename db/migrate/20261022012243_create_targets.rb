class CreateTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :targets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :total_budget
      t.date :deadline
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
