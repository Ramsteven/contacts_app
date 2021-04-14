class AttachedsController < ApplicationController
  before_action :get_attach, only: [:import]

  def index
    @attacheds = current_user.attacheds
  end


  def export_csv
     # @contacts = Employee.all
     # respond_to do |format|
     #  format.html
     #  format.csv { send_data @employees.to_csv, filename: "employees-#{Date.today}.csv",  type: 'text/csv; charset=utf-8' }
    # end
  end

  def import
    begin
     Attached.my_import(@attch_file, current_user)
    rescue => exception
      message = exception.message
      flash[:alert] = "Something wrong happened with the file #{message}"
    end
    redirect_to root_url
  end




  def new
    @attached = current_user.attacheds.new
  end

  def create
    #Attached.name_headers(v, params[:headers])
    #
    @attached = current_user.attacheds.build( attached_csv: set_params[:attached_csv],
    match: params[:headers],
    name: set_params[:attached_csv].original_filename, 
    status: "Waiting"
    )
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

  def get_attach
    @attch_file = current_user.attacheds.find(params[:id])
  end

 end
