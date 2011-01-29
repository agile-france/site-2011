require 'spec_helper'

describe Company do
  it {should have_fields :name, :naf}
  it {should validate_uniqueness_of(:name) }
end