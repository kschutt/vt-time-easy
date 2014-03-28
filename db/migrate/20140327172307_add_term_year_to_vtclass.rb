class AddTermYearToVtclass < ActiveRecord::Migration
  def change
  	add_column :vtclasses, :termyear, :integer
  end
end
