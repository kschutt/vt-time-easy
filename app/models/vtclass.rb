class Vtclass < ActiveRecord::Base
  attr_accessible :course_number, :subject_code, :termyear, :campus, :user_id, :program_id
  belongs_to :user
  belongs_to :program
  # validates :user_id, presence: true
  validates :course_number, presence: true #, numericality: true
  validates :subject_code, presence: true
  # validates :termyear, presence: true
  validates :campus, presence: true
  validate :user_or_program

  def user_or_program
    if self.program.nil? and self.user.nil?
      # errors.add(:user_or_program, "must exist")
    end
  end

  before_validation do
    # raise self.to_yaml
    
  end

def class_details
  classdetails = VtClassDetails.get_details(self)
  classdetails.blank? ? 1 : 0
end
  def campus_name
  	Campu.find_by_vtid(self.campus).name if Campu.find_by_vtid(self.campus)
  end

  def term_name
  	Term.find_by_vtid(self.termyear).name if Term.find_by_vtid(self.termyear)
  end

  def subject_code_name
    Subject.find_by_subject_code(self.subject_code).name if  Subject.find_by_subject_code(self.subject_code)
  end
end
