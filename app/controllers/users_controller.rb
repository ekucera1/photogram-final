class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
    render({ :template => "users/index" })
  end
  
  
end

=begin

def new
  render({ :template => "users/sign_up" })
end

def create
  user = User.new
  user.email = params.fetch("email")
  user.password = params.fetch("password")
  #user.password_confirmation = params.fetch("password_confirmation")
  user.username = params.fetch("username")
  user.private = params.key?("private")
  
  if user.save
    redirect_to("/users/sign_in")
  else
    render({ :template => "users/sign_up" })
  end
end

def sign_in_form
  render({ :template => "users/sign_in" })
end

def sign_in
  email = params.fetch("email")
  password = params.fetch("password")

  user = User.where({ :email => email }).first
  
  if user && user.authenticate(password)
    session.store(:user_id, user.id)
    redirect_to("/")
  else
    render({ :template => "users/sign_in" })
  end
  
end
=end
