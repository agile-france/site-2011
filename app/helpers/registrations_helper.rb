module RegistrationsHelper
  def assign_registration_to_user_path(registration, user)
    "/registrations/#{registration.id}/users/#{user.id}"
  end
end