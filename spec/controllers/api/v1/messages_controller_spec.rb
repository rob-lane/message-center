require 'rails_helper'

RSpec.describe Api::V1::MessagesController, :type => :controller do
  render_views

  login_user

  let!(:test_msg) { FactoryGirl.create(:message, user: @user) }

  let (:body) { JSON.parse(response.body) }

  describe "GET 'index'" do

    subject! { get 'index', format: :json }

    it { is_expected.to be_success }

    it "assigns all users messages" do
      expect(assigns(:messages)).to eq([test_msg])
    end

    it "responds with a JSON body" do
      msg = body['messages'].select {|msg| msg['id'] == test_msg.id }
      expect(msg).to_not be_nil
    end

  end

  describe "GET 'show'" do

    subject! { get 'show', id: test_msg.id, format: :json }

    it { is_expected.to be_success }

    it "assigns the correct message" do
      expect(assigns(:message)).to eq(test_msg)
    end

    it "responds with a JSON body" do
      expect(body['message']['id']).to eq test_msg.id
    end

    context "with an invalid ID" do

      subject! {get 'show', id: 0, format: :json }

      it "responds with an error" do
        expect(response).to have_http_status(500)
      end
    end

  end

  describe "POST 'create'" do

    let!(:test_msg) { FactoryGirl.build(:message) }

    let(:post_json) do
      {message: test_msg.attributes.
          merge(recipients: test_msg.recipients.map(&:email))}
    end

    subject! { post 'create', post_json, format: :json }

    it "responds with a redirect" do
      expect(response).to have_http_status(302)
    end
    it "creates a new message" do
      expect(assigns(:message)).to be_a(Message)
      expect(assigns(:message).id).to_not be_nil
    end

    context "without a body" do

      let!(:test_msg) { FactoryGirl.build(:message, body: nil)}

      it "responds with an error" do
        expect(response).to have_http_status(500)
      end

    end

  end

  describe "Put 'update'" do

    let!(:existing_message) { Message.first || FactoryGirl.create(:message)}

    subject! { put 'update', put_params }

    let(:test_subject) { 'A new subject' }

    let(:test_object) do
      { id: existing_message.id, subject: test_subject }
    end

    let(:put_params) do
      {id: existing_message.id, message: test_object, format: :json}
    end

    it "should update the subject" do
      expect(assigns(:message).subject).to eq(test_subject)
    end

    context "including recipients" do

      let(:put_params) do
        {id: existing_message.id, message: {new_recipients: ['rspec@tester.com'] },
          format: :json}
      end

      it "should send a new notification through ActionMailer" do
        expect {
          put 'update', put_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

    end

  end

  describe "Delete 'destroy'" do

    let(:existing_message) { Message.first || FactoryGirl.create(:message) }

    let(:delete_params) do
      {id: existing_message.id, format: :json}
    end

    it "should destroy the requested message" do
      expect {
        delete 'destroy', delete_params
      }.to change(Message, :count).by(-1)
    end

  end

end
