require 'sendgrid-ruby'
class MailersController < ApplicationController

  def create
    mail_service.send_email(params)
  end

  def mail_service
    MailService.new
  end
end
