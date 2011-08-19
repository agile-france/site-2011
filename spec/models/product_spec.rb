require 'spec_helper'

describe Product do
  it {should have_field(:ref)}
  it {should validate_uniqueness_of(:ref)}
  it {should validate_presence_of(:ref)}
end

