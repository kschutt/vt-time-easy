class AddCampusToClassDetails < ActiveRecord::Migration
  def change
  	add_column :vt_class_details, :campus, :integer
  end
end
