class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.integer :vtid

      t.timestamps
    end
  end
end
