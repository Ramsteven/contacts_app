class FailContactsController  < ApplicationController
  def index
    @faileds = current_user.fail_contacts.paginate(page: params[:page], per_page: 12)
  end

  def show
    @fail = current_user.fail_contacts.find(params[:id])
  end
end
