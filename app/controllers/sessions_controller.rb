class SessionsController < ApplicationController
  def new
    render({ :template => "sessions/sign_in" })
  end

  def create
    email = params.fetch("email")
    password = params.fetch("password")

    user = User.where({ :email => email }).first

    if user && user.authenticate(password)
      session.store(:user_id, user.id)
      redirect_to("/")
    else
      render({ :template => "sessions/sign_in" })
    end
  end
end
