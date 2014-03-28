class AddProgramToVtClass < ActiveRecord::Migration
  def change

  	add_column :vtclasses, :program_id, :integer
  end
end
