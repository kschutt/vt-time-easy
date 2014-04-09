class Program < ActiveRecord::Base
  attr_accessible :name, :another_name, :vtclasses_attributes
  has_many :vtclasses
  accepts_nested_attributes_for :vtclasses, allow_destroy: true
end
