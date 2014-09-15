class MessageMailer < ActionMailer::Base
  default from: "from@msgs.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.send_mesage.subject
  #
  def send_message(message, recips = nil)
    @html_body = message.body
    @text_body = message.text_body
    recips ||= message.recipients.map(&:email)
    mail to: recips, subject: message.subject
  end
end
