class PaymentsController < ApplicationController
  def invoice
    @invoice ||= Invoice.find(params[:invoice_id])
  end
  helper_method :invoice
end