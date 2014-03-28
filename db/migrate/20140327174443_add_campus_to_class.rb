class AddCampusToClass < ActiveRecord::Migration
  def change

  	add_column :vtclasses, :campus, :integer
  end
end
