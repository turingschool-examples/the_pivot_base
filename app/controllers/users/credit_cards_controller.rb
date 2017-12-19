class Users::CreditCardsController < ApplicationController
  def new
    CreditCard.new
  end

  def create
    binding.pry
    @user = current_user
    @cc = CreditCard.new(credit_card_params)
    if @cc.save
      redirect_to credit_card_path(@cc)
    else
      render :new
    end
  end

  private

    def credit_card_params
      params.require(:credit_card).permit(:last4digits, :expiration_month, :expiration_year)
    end
end