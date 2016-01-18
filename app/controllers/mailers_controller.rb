require 'sendgrid-ruby'
class MailersController < ApplicationController

  def create
    mail_service.send_email(params)
  end

  def mail_service
    MailService.new(api_key: 'YOUR_SENDGRID_APIKEY')
  end
end
