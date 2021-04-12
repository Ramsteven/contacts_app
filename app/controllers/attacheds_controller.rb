class AttachedsController < ApplicationController
  def index
    @attached = Attached.all
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
    @attached = Attached.new(set_params)
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
