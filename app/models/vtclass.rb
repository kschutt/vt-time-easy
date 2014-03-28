class Vtclass < ActiveRecord::Base
  attr_accessible :course_number, :subject_code, :termyear, :campus, :user_id
  belongs_to :user
  validates :user_id, presence: true
  validates :course_number, presence: true, numericality: true
  validates :subject_code, presence: true
  # validates :termyear, presence: true
  validates :campus, presence: true

  def campus_name
  	Campu.find_by_vtid(self.campus).name if Campu.find_by_vtid(self.campus)
  end

  def term_name
  	Term.find_by_vtid(self.termyear).name if Term.find_by_vtid(self.termyear)
  end
end
