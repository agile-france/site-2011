module Xero
  def client
    @client ||= XeroMin::Client.new(ENV['xero_consumer_key'], ENV['xero_secret_key']).private!(ENV['xero_private_key_file'])
  end
  module_function :client
end