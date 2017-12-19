class Users::CreditCardsController < ApplicationController
  def new
    @credit_card = CreditCard.new
  end

  def create
    binding.pry
    @user = current_user
    @cc = CreditCard.new(credit_card_params)
    CreditCard.last4digits(current_user, params[:credit_card][:card_number])
    if @cc.save
      redirect_to credit_card_path(@cc)
    else
      render :new
    end
  end

  private

    def credit_card_params
      params.require(:credit_card).permit(:card_number, :exp_month, :exp_year)
    end
end