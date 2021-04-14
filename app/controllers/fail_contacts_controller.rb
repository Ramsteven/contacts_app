class FailContactsController  < ApplicationController
  def index
    @faileds = current_user.fail_contacts
  end

  def show
    @fail = current_user.fail_contacts.find(params[:id])
  end
end
