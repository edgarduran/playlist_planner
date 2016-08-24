require 'sendgrid-ruby'
class MailersController < ApplicationController

  def create
    sent = mail_service.send_email(params, request)
    render json: sent
  end

  def mail_service
    MailService.new
  end
end
