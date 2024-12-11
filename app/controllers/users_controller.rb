class UsersController < ApplicationController

  #before_action :authenticate_user!, only: [:index]

  #def index
    #@users = User.all.order({ :username => :asc })
    #render({ :template => "users/index" })
  #end

 # def show
  #  @user = User.where({ :username => params.fetch("username") }).first
  #  render({ :template => "users/show" })
  #end

  def feed
    username = params.fetch("username")
    user = User.where({ :username => username }).at(0)

    if user
      followed_users = user.followed_users
      @photos = Photo.where({ :owner_id => followed_users.map(&:id) })
    else
      @photos = []
    end

    render({ :template => "users/feed" })
  end

  def index
    @users = User.all
    render({ :template => "users/index" })
  end
  before_action :set_user, only: [:show]

  def show
    unless current_user.follows?(@user)
      flash.now[:alert] = "You must follow the user to view their full profile."
    end
    render({ :template => "users/show" })
  end

  private

  def set_user
    @user = User.where({ :username => params.fetch("username") }).first
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
