class AttachedsController < ApplicationController
  before_action :get_attach, only: [:import]

  def index
    @attacheds = current_user.attacheds.paginate(page: params[:page], per_page: 12)
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
    if params[:attached].nil?
      flash[:alert] = "You shoulbe attached an file, please click on choose file"
      redirect_to root_path
      return
    end

    file = set_params[:attached_csv]
    @headers = 0
    begin 
      @head = CSV.open(file.path, headers: true).read.headers.count
    rescue
    end

    @attached = current_user.attacheds.build( attached_csv: set_params[:attached_csv],
    match: params[:headers],
    name: set_params[:attached_csv].original_filename, 
    headers_csv: @head,
    status: "Waiting" )
    if @attached.save
      redirect_to root_path
      flash[:alert] = "file attached successfully"
    else
      message = @attached.errors.full_messages
      flash[:alert] = "Something wrong happened with the file #{message}"
      redirect_to root_path
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
