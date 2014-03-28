require 'rubygems'
require 'nokogiri'

class VtclassFetch
  def fetch_classes(subject_code, term, campus)
    @options = { :body => {:subj_code => subject_code, :termyear => term, campus: campus,CORE_CODE: "AR%"}}
    response = HTTParty.post("https://banweb.banner.vt.edu/ssb/prod/HZSKVTSC.P_ProcRequest", @options)
    page = Nokogiri::HTML(response)
    # get campuses
    campuses_select = page.css("select[name='CAMPUS']")
    		campuses = campuses_select.css("option")
    campuses.each_with_index do |item, index|
    	value = item.xpath("@value").text
    	name = item.text.strip.gsub("&nbsp", "")
    	Campu.find_or_create_by_name_and_vtid(name,value)
    end
    # get terms
    terms_select = page.css("select[name='TERMYEAR']")
    		terms = terms_select.css("option")
    terms.each_with_index do |item, index|
    	value = item.xpath("@value").text
    	name = item.text.strip.gsub("&nbsp", "")
    	Term.find_or_create_by_name_and_vtid(name,value) if value != "0" and value != 0
    end
    # get subjects
    subjects_select = page.css("script")[1].text
    subjects = subjects_select.scan(/Option\(([^;]*)\)/)
    subjects.each_with_index do |item, index|
    	subject_split = item[0].split(',')
    	subject_code_id = subject_split[1].gsub('"', "")
    	name = subject_split[0].gsub('"', "")
    	Subject.find_or_create_by_subject_code_and_name(subject_code_id,name) if !subject_code_id.include?("%")
    end
    # get datatable
    datatable = page.css("table.dataentrytable tr")
    classes = []  
    last_class = []
    datatable.each_with_index do |item, index|
    	if index == 0
        	# nothing
    	else
    		columns = item.css("td")
    		crn = columns[0].text.strip.gsub("&nbsp", "")
    		course_number = columns[1].text.strip.gsub("&nbsp", "")
    		additional_times = columns[4] ? columns[4].text.strip.downcase.include?("additional times") : false
    		title = columns[2] ? columns[2].text.strip.gsub("&nbsp", "") : ""
            instructor = columns[6] ? columns[6].text.strip.gsub("&nbsp", "") : "Staff"
    		if columns[7].nil? or columns[7].text.strip == "(ARR)"
    		days =  "arr"
    		else
    		days = columns[7].text.strip.gsub("&nbsp", "")
    		end
    		begin_time = days == "arr" ? "arr" : ( columns[8] ? columns[8].text.strip.gsub("&nbsp", ""): "")	
    		end_time =  days == "arr" ? "arr" : ( columns[9] ? columns[9].text.strip.gsub("&nbsp", "" ) : "")
    		locations =  days == "arr" ? "TBA" : (columns[10] ? columns[10].text.strip.gsub("&nbsp", "") : "TBA")
    		new_class = [crn, course_number, title, days, begin_time, end_time, locations,instructor]
    		if additional_times and last_class
    			last_class[3] = columns[5].text.strip.gsub("&nbsp", "")
    			last_class[4] = columns[6].text.strip.gsub("&nbsp", "")
    			last_class[5] = columns[7].text.strip.gsub("&nbsp", "")
                last_class[6] = columns[8].text.strip.gsub("&nbsp", "")
    			classes << last_class if !classes.include? last_class
    		elsif !crn.blank? and !course_number.blank? and !title.blank? and !days.blank?
    			last_class = new_class.dup
    			classes << new_class if !classes.include? new_class
    		end
    	end
	end
	classdetails = VtClassDetails.find_or_create_by_subject_code_and_term_and_campus(subject_code, term, campus)
	classdetails.classes = classes.to_json
	classdetails.save!
	classdetails
  end
end