class CreateVtclasses < ActiveRecord::Migration
  def change
    create_table :vtclasses do |t|
      t.string :subject_code
      t.integer :course_number

      t.timestamps
    end
  end
end
