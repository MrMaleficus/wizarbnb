class ModifyRatingTypes < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :rating
    add_column :services, :rating, :float, default: 0
  end
end
