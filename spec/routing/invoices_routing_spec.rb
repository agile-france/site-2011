require 'spec_helper'

describe 'invoices routes' do
  specify {
    {:get => '/invoices/1/payments/new'}.should route_to :controller => 'payments', :action => 'new', :invoice_id => "1"
  }
end