module ApplicationHelper

  def add_new_class(params)

    @vtclass = Vtclass.new(params[:vtclass])
    @vtclass.user = current_user if current_user and params[:vtclass][:program_id].blank?
    @vtclass.program_id = params[:vtclass][:program_id] if !params[:vtclass][:program_id].blank?
    if @vtclass.campus != 0 and params[:add_bburg] == 'true' # always adding blacksburg for now
    @vtclass_bburg = @vtclass.dup
    @vtclass_bburg.campus = 0
    @vtclass_bburg.save!
    end
    @vtclass
  end

  def check_for_multiple_classes(params)
    if params[:vtclass][:course_number].include? ","
      course_numbers = params[:vtclass][:course_number].split(',')
      course_numbers.each do |cn|
        cn = Integer(cn) rescue nil
        if cn
        new_params = params.dup
        new_params[:vtclass][:course_number] = cn
        @vtclass = add_new_class(new_params)
        @vtclass.save!
      end
      end
    else
      @vtclass = add_new_class(params)
    end
    @vtclass
  end
  
	def random_alphanumeric(size=16)
		chars = ('a'..'z').to_a + ('A'..'Z').to_a
		(0...size).collect {  chars[Kernel.rand(chars.length)] }.join
	end

	def link_to_add_fields(name, f, association, current_token = nil)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s + "/fields", f: builder)
		end
		association_str = current_token ? "%s-%s" % [association.to_s.singularize, current_token] : association
		link_to(name, '#', class: "add-fields", data: {id: id, fields: fields.gsub("\n", ""), dismiss: "modal", association: association_str})
	end

	def dynamic_model_add(name, f, partial, header = false)
		current_token = random_alphanumeric
		content_tag(:tr) do
			td0 = content_tag(:td) do
				content_tag(:span, "#{name.humanize}") +
				content_tag(:br) + 
				link_to_add_fields("Add #{name.downcase.singularize.humanize}", f, name, current_token)
			end
			td1 = content_tag(:td, id: "#{"%s-%s" % [name.downcase.singularize, current_token]}-cell")  do
				content_tag(:table, :class => "table table-bordered") do
					f.fields_for name do |builder|
						render "#{name.downcase.pluralize}/#{partial}", :f => builder
					end
				end
			end
			td0 + td1
		end
	end
end
