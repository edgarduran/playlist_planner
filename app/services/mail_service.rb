require 'sendgrid-ruby'
class MailService
  attr_reader :client

  def initialize(api_key)
    @client = SendGrid::Client.new(api_key: ENV['YOUR_SENDGRID_APIKEY'])
  end

  def send_email(params)
    mail = SendGrid::Mail.new do |m|
      m.to = params[:email]
      m.from = 'taco@cat.limo'
      m.subject = 'Contribute to my Playlist'
      m.text = 'I heard you like pineapple.'
    end
    client.send(mail)
  end

  # # As a hash
  # client = SendGrid::Client.new(api_key: 'YOUR_SENDGRID_APIKEY')
  #
  # # Or as a block
  # client = SendGrid::Client.new do |c|
  #   c.api_key = 'YOUR_SENDGRID_APIKEY'
  # end

end
