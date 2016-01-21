require 'sendgrid-ruby'
class MailService
  attr_reader :client

  def initialize
    @client = SendGrid::Client.new(api_key: ENV['YOUR_SENDGRID_APIKEY'])
  end

  def send_email(params)
    mail = SendGrid::Mail.new do |m|
      m.to = params[:email]
      m.from = 'taco@cat.limo'
      m.subject = 'Contribute to my Playlist'
      m.text = "https://playlist-planner.herokuapp.com/requests/#{path_name(params)}"
    end
    client.send(mail)
  end

  private

  def path_name(params)
    spotify_id = params[:rspotify].sub("#", "%23")
    "#{spotify_id}?pl_id=#{params[:pl_id]}&pl_name=#{params[:pl_name]}&user=#{params[:user]}&user_id=#{params[:user_id]}"
  end


end
