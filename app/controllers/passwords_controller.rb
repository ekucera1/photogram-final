class PasswordsController < ApplicationController
  def new
    render({ :template => "passwords/forgot" })
  end

  def create
    email = params.fetch("email")
    user = User.where({ :email => email }).first

    if user
      # Logic to send password reset instructions
      redirect_to("/sign_in")
    else
      render({ :template => "passwords/forgot" })
    end
  end
end
