class PasswordsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      token = SecureRandom.hex(20)
      user.update!(reset_password_token: token, reset_password_sent_at: Time.current)
      UserMailer.with(user: user, token: token).reset_password.deliver_later
    end
    redirect_to root_path, notice: "If the email exists, reset instructions were sent"
  end

  def edit
    @token = params[:token]
  end

  def update
    user = User.find_by(reset_password_token: params[:token])
    if user && user.reset_password_sent_at && user.reset_password_sent_at > 2.hours.ago
      if user.update(password_params.merge(reset_password_token: nil, reset_password_sent_at: nil))
        redirect_to new_session_path, notice: "Password updated"
      else
        flash.now[:alert] = user.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to new_password_path, alert: "Reset link is invalid or expired"
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end


