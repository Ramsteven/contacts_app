class AttachedsController < ApplicationController
  before_action :get_attach, only: [:import]

  def index
    @attacheds = user_attc.paginate(page: params[:page], per_page: 12)
  end


  def new
    @attached = user_attc.new
  end

  def create
    if params[:attached].nil?
      flash[:alert] = "You shoulbe attached an file, please click on choose file"
      redirect_to root_path
      return
    end
    file = set_params
    begin 
      columns = CSV.open(file.path, headers: true).read.headers.count
    rescue
    end
    @attached = user_attc.build( 
      attached_csv: set_params,
      match: params[:headers],
      name: set_params.original_filename, 
      headers_csv: columns,
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


  def import
    ImportWorker.perform_async(params[:id])
    flash[:notice] = "Importing contacts from file.."
    redirect_to attacheds_path
  end

  def destroyer
    #delete all associations of user
    DestroyWorker.perform_async(params[:id])
    flash[:notice] = "Deleting all"
    redirect_to attacheds_path
  end


  
  private
  def set_params
    params.require(:attached).permit(:attached_csv)[:attached_csv]
  end

  def get_attach
    attch_file = Attached.find(params[:id])
  end

  def user_attc
    current_user.attacheds
  end

 end
