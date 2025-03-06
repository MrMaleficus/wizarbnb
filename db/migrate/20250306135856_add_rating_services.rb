class AddRatingServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :rating, :integer, default: 0
  end
end
