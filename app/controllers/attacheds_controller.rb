class AttachedsController < ApplicationController
  def index
    @attacheds = current_user.attacheds.all
  end


  def export_csv
     # @contacts = Employee.all
     # respond_to do |format|
     #  format.html
     #  format.csv { send_data @employees.to_csv, filename: "employees-#{Date.today}.csv",  type: 'text/csv; charset=utf-8' }
    # end
  end

  def new
    @attached = current_user.attacheds.new
  end

  def create
    #Attached.name_headers(v, params[:headers])
    #
    byebug
    @attached = Attached.new(set_params)
    @attached.match = params[:headers]
    @attached.name = set_params[:attached_csv].original_filename 
    @attached.user = current_user
    @attached.status = "Waiting"
    if @attached.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  
  private
  def set_params
    params.require(:attached).permit(:attached_csv)
  end

 end
