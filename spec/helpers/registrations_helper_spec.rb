require 'spec_helper'

describe RegistrationsHelper do
  describe "#assign_registration_to_user_path" do
    let(:registration) {Fabricate.build(:registration)}
    let(:user) {Fabricate.build(:user)}
    specify {
      assign_registration_to_user_path(registration, user).should == "/registrations/#{registration.id}/users/#{user.id}"
    }
  end
end