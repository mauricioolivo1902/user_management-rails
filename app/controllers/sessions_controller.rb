class SessionsController < ApplicationController
  def new
  end

def create
Rails.logger.debug "Session Params: #{params[:session].inspect}"
  user = User.find_by(username: params[:session][:username].downcase)
  if user&.authenticate(params[:session][:password])
    session[:user_id] = user.id
    redirect_to users_url, notice: 'Sesión iniciada exitosamente.'
  else
    flash.now[:alert] = 'Credenciales inválidas.'
    render :new, status: :unprocessable_entity
  end
end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Sesión cerrada exitosamente.'
  end
end