class SessionsController < ApplicationController
  def destroy
    # Placeholder logout logic (no auth system yet)
    redirect_to root_path, notice: "You have been logged out."
  end
end
