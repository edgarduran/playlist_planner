require 'sendgrid-ruby'
class MailService
  attr_reader :client

  def initialize
    @client = SendGrid::Client.new(api_key: ENV['YOUR_SENDGRID_APIKEY'])
  end

  def send_email(params, request)
    mail = SendGrid::Mail.new do |m|
      m.to = create_emails_array(params[:email])
      m.from = 'make-a-playlist@sweetapp.yeah'
      m.subject = 'Contribute to my Playlist'
      m.text = "Copy and paste the provided into a browser to contribute to the playlist(make sure to include whole link):"
      m.text = path_name(params,request)
      m.html = "<html><p>Copy and paste the provided into a browser to contribute to the playlist(make sure to include whole link):<br><a href='#{path_name(params,request)}'>Suggest songs for playlist</a></html>"
    end
    client.send(mail)
  end

  def create_emails_array(emails)
    emails.split
  end

  private

  def path_name(params, request)
    (request.env['HTTP_REFERER']).gsub('playlists', 'requests')
  end


end
