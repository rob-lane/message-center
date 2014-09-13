require 'rails_helper'

RSpec.describe Api::V1::MessagesController, :type => :controller do

  describe "GET 'index'" do

    subject { get 'index' }

    it { is_expected.to be_success }

  end

  describe "GET 'show'" do

    subject { get 'show' }

    it { is_expected.to be_success }

  end

end
