class ContactsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @contacts = 
    @contacts = @user.contacts.paginate(page: params[:page], per_page: 12)
  end


  def export_csv
     # @contacts = Employee.all
     # respond_to do |format|
     #  format.html
     #  format.csv { send_data @employees.to_csv, filename: "employees-#{Date.today}.csv",  type: 'text/csv; charset=utf-8' }
    # end
  end

  def new
    @contact = current_user.contacts.new
  end

  def create
    @contact = current_user.contacts(set_params)
    if @contact.save
      flash[:notice] = "Usuario #{ @contact.email} creado "
      redirect_to root_path
    else
      render 'new'
    end
  end

  def import
    begin
     Contact.my_import(params[:file], current_user)
    rescue => exception
      message = exception.message
      flash[:alert] = "Something wrong happened with the file #{message}"
    end
    redirect_to root_url
  end

  private

  def set_params
    params.require(:contact).permit(:fullname,:address,:phone,:email, :credit_card, :franschise, :birth_date)
  end

end
