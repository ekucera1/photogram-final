class UsersController < ApplicationController
  def new
    render({ :template => "users/sign_up" })
  end

  def create
    user = User.new
    user.email = params.fetch("email")
    user.password = params.fetch("password")
    user.password_confirmation = params.fetch("password_confirmation")
    user.username = params.fetch("username")
    user.private = params.key?("private")
    
    if user.save
      redirect_to("/sign_in")
    else
      render({ :template => "users/sign_up" })
    end
  end
  
  # Display a user's profile
  def show
    @user = User.where({ :id => params.fetch("id") }).at(0)
    render({ :template => "users/show" })
  end

  # List all users
  def index
    @users = User.all
    render({ :template => "users/index" })
  end
end
