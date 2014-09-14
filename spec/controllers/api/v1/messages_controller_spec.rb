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

  end

  describe "POST 'create'" do

    let!(:test_msg) { FactoryGirl.build(:message) }

    let(:post_json) { {message: new_msg }.to_json }

    subject! { post 'create', message: post_json, format: :json }

    it { is_expected.to be_success }

    it "creates a new message" do
      expect(assigns(:message)).to be_a_new(Message)
    end

    it "responds with a JSON body" do
      expect(responds.body).to eq(expected_json)
    end

  end

end
