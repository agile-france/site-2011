require 'spec_helper'

describe Session do  
  touch_db_with(:session) {Fabricate(:session, :tags_array => %w(courage respect))}

  it 'can hold an array of tag' do
    assert {session.tags_array.include?('courage')}
  end
  
  it 'can be queried for a tag' do
    # somehow clumsy statement : we need session to be created before searching for it ...
    assert {session.tags_array.size == 2}
    # look for it now ?
    sessions = Session.any_in(:tags_array => ['courage'])
    assert {sessions.first == session}
  end
  
  it {should have_fields(:created_at, :updated_at).of_type(Time)}
  it {should have_fields(:level, :age, :format)}
  
  describe "choices" do
  end
  
  describe "capacity" do
    it {should have_fields(:capacity).of_type(Integer)}
    it 'validates capacity in range' do
      deny {Session.new(:title => 'zoo', :capacity => 9).valid?}
      deny {Session.new(:title => 'zoo', :capacity => 51).valid?}
    end
  end
  
  describe "title" do
    it 'should have a limit to 150 chars (tech)' do
      v = Session.validators_on(:title).select{|v| v.class.to_s =~ /Length/}.first
      assert {v.options[:maximum] <= 150}
    end
    it 'should have a limit to 150 chars (functional)' do
      s = Session.new(:title => ('a'*151))
      deny {s.valid?}
    end
  end
  
  describe "validation and i18n" do
    it "should have a :fr translation" do
      I18n.locale = :fr
      i18n = Session.new(:capacity => 'a')
      deny {i18n.valid?}
      assert {i18n.errors[:capacity].first =~ /dans l'intervalle/}
    end
  end
  
  describe "rating" do
    context "no review" do
      it "has a default stars score of 0" do
        assert {session.stars == 0}
      end
      it {deny {session.rated?}}
    end
    
    context "with review" do
      before do
        session.ratings << Rating.new(:stars => 2)
      end
      it {assert {session.rated?}}
      it "has a stars of 2" do
        assert {session.stars == 2}
      end
    end
  end
end
