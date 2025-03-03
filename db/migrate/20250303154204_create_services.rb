class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.integer :daily_rate
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
