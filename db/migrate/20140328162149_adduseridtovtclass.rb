class Adduseridtovtclass < ActiveRecord::Migration
  def change
  	add_column :vtclasses, :user_id, :integer
  end
end
