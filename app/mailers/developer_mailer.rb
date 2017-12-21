class DeveloperMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Thank you for registering as a Developer!")
  end

end
