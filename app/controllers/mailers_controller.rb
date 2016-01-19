require 'sendgrid-ruby'
class MailersController < ApplicationController

  def create
    mail_service.send_email(params)
    flash[:success] = "Email Sent"
    redirect_to playlists_path
  end

  def mail_service
    MailService.new
  end
end
