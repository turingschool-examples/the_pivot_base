class Users::CreditCardsController < ApplicationController
  def new
    CreditCard.new
  end
end