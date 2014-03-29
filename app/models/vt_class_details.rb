class VtClassDetails < ActiveRecord::Base
  attr_accessible :classes, :subject_code, :term, :campus

  def self.get_details(vtclass)
  	classdetails = VtClassDetails.find_by_subject_code_and_term_and_campus(vtclass.subject_code,vtclass.termyear,vtclass.campus)

  	if classdetails.blank?
		fetcher = VtclassFetch.new
    	classdetails = fetcher.fetch_classes(vtclass.subject_code,vtclass.termyear,vtclass.campus)
    end
    classes = JSON.parse(classdetails.classes)
	return_class = []
	classes.each do |c|
	  		if c[1] == "%s-%s" % [vtclass.subject_code,vtclass.course_number]
	  			return_class << c
	  		end
	  	end
	  	return_class
	  end

	    def campus_name
  	Campu.find_by_vtid(self.campus).name if Campu.find_by_vtid(self.campus)
  end

  def term_name
    Term.find_by_vtid(self.term).name if Term.find_by_vtid(self.term)
  end 
   def subject_code_name
    Subject.find_by_subject_code(self.subject_code).name if  Subject.find_by_subject_code(self.subject_code)
  end
end
