class VtClassDetailsController < ApplicationController
  # authorize_resource
  def index
  	@classdetails = VtClassDetails.order(:campus,:subject_code)
  end
  def users
  	if current_user and current_user.admin
  	@users = User.order(:email)
  else
  	@users = [current_user]
  end
  end
  def show_user
  	if current_user and current_user.admin
  		@user = User.find(params[:id])
  	else
  		@user = current_user
  	end
  		@vtclasses = @user.vtclasses

  end
  def show
    @vt_class_details = VtClassDetails.find(params[:id])
  end
end
