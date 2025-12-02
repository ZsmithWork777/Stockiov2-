class ProfileController < ApplicationController
  def show
    # Placeholder data — later this will be real user data
    @name = "Zachary Smith"
    @email = "z.m.smith@outlook.com"
    @created_at = Time.now - 30.days
  end
end
