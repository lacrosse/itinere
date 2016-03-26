class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user_or_guest
    @_current_user_or_guest ||=
      if current_user
        if current_guest_user
          current_guest_user.trip_plans.update_all(user_id: current_user.id)
          current_guest_user.destroy
          session[:guest_user_id] = nil
        end

        current_user
      else
        guest_user
      end
  end

  alias authenticate_user_or_guest current_user_or_guest

  private

  def guest_user
    current_guest_user || new_guest_user
  end

  def current_guest_user
    (@_current_guest_user ||= User.find_by(id: session[:guest_user_id])) if session[:guest_user_id]
  end

  def new_guest_user
    u = User.new(email: "guest-#{SecureRandom.hex}")
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end
end
