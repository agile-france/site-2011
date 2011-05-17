class Mailer < ActionMailer::Base
  default from: 'orga@conf.agile-france.org'

  def invoice_ready(invoice)
    @invoice = invoice
    mail to: invoice.user.email
  end
end
