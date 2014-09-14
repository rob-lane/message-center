require "rails_helper"

RSpec.describe MessageMailer, :type => :mailer do
  describe "send_mesage" do
    let(:msg) { FactoryGirl.create :message }
    let(:recipients) { msg.recipients.map(&:email) }
    let(:mail) { MessageMailer.send_mesage(msg) }

    it "renders the headers" do
      expect(mail.subject).to eq(msg.subject)
      expect(mail.to).to eq(recipients)
      expect(mail.from).to eq(["from@msgs.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(msg.body)
    end
  end

end
