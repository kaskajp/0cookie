class UserMailer < ApplicationMailer
  default from: ENV.fetch("SMTP_FROM", "no-reply@0cookie.local")

  def reset_password
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.email, subject: "Reset your password")
  end
end


