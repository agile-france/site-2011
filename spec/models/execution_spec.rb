require 'spec_helper'

describe Execution do
  it {should be_referenced_in(:user)}
  it {should be_referenced_in(:product)}
  it {should be_referenced_in(:order)}
  
  it {should have_field(:side).with_default_value_of('B')}
  it {should validate_inclusion_of(:side).to_allow('B', 'A')}

  it {should have_field(:price).of_type(Float).with_default_value_of(0)}
  it {should validate_numericality_of(:price)}

  it {should have_field(:quantity).of_type(Integer).with_default_value_of(1)}
  it {should validate_numericality_of(:quantity)}
  
  it {should have_field(:ref)}
  # XXX validates length of ref in 0..20 
end