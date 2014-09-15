class MessageMailer < ActionMailer::Base
  default from: "from@msgs.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.send_mesage.subject
  #
  def send_message(message)
    @html_body = message.body
    @text_body = Nokogiri::HTML(@html_body).xpath("//text()").to_s
    mail to: message.recipients.map(&:email), subject: message.subject
  end
end
