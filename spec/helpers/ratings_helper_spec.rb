require 'spec_helper'

describe RatingsHelper do
  let(:explained) {Fabricate(:session)}
  
  describe "rating_id_for" do
    it "returns a fold : id for resource and rating" do
      id = rating_id_for(explained)
      assert {id == "#{id_for_resource(explained)}_rating"}
    end
  end
end