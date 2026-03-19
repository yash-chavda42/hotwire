class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      respond_to do |format|
        format.html { redirect_to notes_path }
      end
    else
      flash.now[:alert] = "Invalid email or password"

      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end