require 'spec_helper'

describe Rating do
  it {should have_field(:stars).of_type(Integer).with_default_value_of(0)}
  describe "star validation" do
    it "star is in 1..5 range" do
      deny {Rating.new(:stars => 0).valid?}
      deny {Rating.new(:stars => 6).valid?}
    end
  end
  
  describe "build" do
    let(:john) {Fabricate(:user)}
    let(:explained) {Fabricate(:session)}
    it "built with a user has no effect (XXX)" do
      rating = Rating.new(:stars => 5, :user => john)
      deny {rating.user == john}
    end
    it "can be built with a user" do
      rating = Rating.new(:stars => 5)
      rating.user = john
      assert {rating.user == john}
    end
  end
end