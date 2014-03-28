class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campus do |t|
      t.string :name
      t.integer :vtid

      t.timestamps
    end
  end
end
