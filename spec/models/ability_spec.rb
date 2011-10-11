
require 'spec_helper'

describe Ability do
  describe "a user" do
    touch_db_with(:cie) { Fabricate(:company) }
    touch_db_with(:abailly) { Fabricate(:user, email: 'abailly@mail.no', company: cie) }
    touch_db_with(:haskell) { Fabricate(:session, user: abailly) }
    let(:ability) { Ability.new(abailly) }
    it "can update his session" do
      assert { ability.can? :update, haskell }
    end
    it "can update his company" do
      assert { ability.can? :update, cie }
    end
    it "can not vote for his session" do
      deny { ability.can? :vote, haskell }
    end
  end

  describe "admin" do
    let(:admin) { Fabricate.build :user, admin: true }
    let(:ability) { Ability.new admin }
    it "can manage all :)" do
      assert { ability.can? :manage, User }
    end
  end
end