class UserMailer < ApplicationMailer
  def bienvenida
    @user = params[:user]
    @username = @user.nombre
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
  
end
