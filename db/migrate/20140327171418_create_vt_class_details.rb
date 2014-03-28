class CreateVtClassDetails < ActiveRecord::Migration
  def change
    create_table :vt_class_details do |t|
      t.string :subject_code
      t.integer :term
      t.text :classes

      t.timestamps
    end
  end
end
