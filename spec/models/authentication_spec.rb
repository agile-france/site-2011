require 'spec_helper'

describe Authentication do
  it {should have_field(:user_info).of_type(Hash)}
  it {should have_field(:activated).of_type(Boolean).with_default_value_of(false)} 
  
  describe "self.actived?|inactived?" do
    before do
      @a, @b, @c = [:a, :b, :c].map{|provider| Fabricate(:authentication)}
      @b.update_attributes :activated => true
    end
    it 'return the active authentications' do
      assert {Authentication.activated?.to_a == [@b]}
    end
    it 'or the inactive ones' do
      [@a, @c].each do |a|
        assert {Authentication.deactivated?.include? a}
      end
    end
  end
  
  describe "criteria dsl can chain with activated?" do
    let(:user) {Fabricate :user}
    before do
      @o = user.authentications.create!(:activated => true)
    end
    it 'user.authentications can use it' do
      assert {user.authentications.activated?.to_a == [@o]}
    end
    it 'can iterate on it' do
      as = user.authentications.activated?.reduce([]){|acc, a| acc << a}
      assert {as == [@o]}
    end
  end
end