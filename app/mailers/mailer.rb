#encoding: utf-8
class Mailer < ActionMailer::Base
  default from: 'orga@conf.agile-france.org'

  def invoice_ready(invoice, user=invoice.user)
    @invoice = invoice
    attachments[invoice.pdf_filename] = File.read("#{Rails.public_path}#{invoice.pdf_url}") if invoice.pdf_url
    mail to: user.email, subject: "Votre facture #{invoice.ref} pour la Conférence Agile France 2011"
  end
end
