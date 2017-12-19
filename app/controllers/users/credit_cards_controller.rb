class Users::CreditCardsController < ApplicationController
  def new
    @credit_card = CreditCard.new
  end

  def create
    @user = current_user
    @cc = CreditCard.new(credit_card_params)
    CreditCard.last4digits(@cc, params[:credit_card][:card_number])
    # StripeTool.add_card(@user.stripe_customer_id, @user.stripe_token)
    if @cc.save
      redirect_to users_credit_card_path(@cc)
    else
      render :new
    end
  end

  def show
    @credit_card = CreditCard.find(params[:id])
  end

  private

    def credit_card_params
      params.require(:credit_card).permit(:card_number, :exp_month, :exp_year)
    end
end