require 'rails_helper'

RSpec.describe Api::V1::MessagesController, :type => :controller do
  render_views

  let!(:test_msg) { FactoryGirl.create(:message) }

  let (:expected_json) { {message: test_msg}.to_json }

  describe "GET 'index'" do

    subject! { get 'index', format: :json }

    let (:expected_json) { {messages: [test_msg] }.to_json }

    it { is_expected.to be_success }

    it "assigns all messages" do
      expect(assigns(:messages)).to eq([test_msg])
    end

    it "responds with a JSON body" do
      expect(response.body).to eq(expected_json)
    end

  end

  describe "GET 'show'" do

    subject! { get 'show', id: test_msg.id, format: :json }

    it { is_expected.to be_success }

    it "assigns the correct message" do
      expect(assigns(:message)).to eq(test_msg)
    end

    it "responds with a JSON body" do
      expect(response.body).to eq(expected_json)
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

    let(:post_json) { {message: test_msg }.to_json }

    subject! { post 'create', {message: test_msg.attributes}, format: :json }

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

end
