require 'rails_helper'

RSpec.describe Api::V1::MessagesController, :type => :controller do

  let!(:test_msg) { FactoryGirl.create(:message) }

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

    let (:expected_json) { test_msg.to_json }

    it { is_expected.to be_success }

    it "assigns the correct message" do
      expect(assigns(:message)).to eq(test_msg)
    end

    it "responds with a JSON body" do
      expect(response.body).to eq(expected_json)
    end



  end

end
