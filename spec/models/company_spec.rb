require 'spec_helper'

describe Company do
  it {should have_fields :name, :naf}
end