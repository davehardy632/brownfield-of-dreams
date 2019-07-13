class UserActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: 'User Activation')
  end
end
