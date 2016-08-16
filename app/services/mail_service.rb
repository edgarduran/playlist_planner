require 'sendgrid-ruby'
class MailService
  attr_reader :client

  def initialize
    @client = SendGrid::Client.new(api_key: ENV['YOUR_SENDGRID_APIKEY'])
  end

  def send_email(params)
    mail = SendGrid::Mail.new do |m|
      m.to = create_emails_array(params[:email])
      m.from = 'make-a-playlist@sweetapp.yeah'
      m.subject = 'Contribute to my Playlist'
      m.text = "Copy and paste the provided into a browser to contribute to the playlist(make sure to include whole link):"
      m.text = "https://playlist-planner.herokuapp.com/requests/#{path_name(params)}"
      m.html = "<html><p>Copy and paste the provided into a browser to contribute to the playlist(make sure to include whole link):<br><a href='https://playlist-planner.herokuapp.com/requests/#{path_name(params)}'>Suggest songs for playlist</a></html>"
    end
    client.send(mail)
  end

  def create_emails_array(emails)
    emails.split
  end

  private

  def path_name(params)
    spotify_id = params[:rspotify].sub("#", "%23")
    "#{spotify_id}?pl_id=#{params[:pl_id]}&pl_name=#{params[:pl_name]}&user=#{params[:user]}&user_id=#{params[:user_id]}"
  end


end
