class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password))
      if @user.save
        session[:user_id] = @user.id
          flash[:notice] = "Successfully signed up"
        redirect_to cheeses_path
      else
        render :new
      end
    end

end
