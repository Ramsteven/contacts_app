class ContacsController < ApplicationController
  def index
  end

  def create
    User.create(params.require(:contact).permit(:fullname, :address, :phone, :credit_card, :franchise, :birth_date))
  end
end
