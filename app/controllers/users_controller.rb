class UsersController < ApplicationController
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
