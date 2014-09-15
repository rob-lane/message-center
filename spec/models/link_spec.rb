require 'rails_helper'

RSpec.describe Link, :type => :model do

  context "built" do

    subject { FactoryGirl.build(:link) }

    it { is_expected.to be_valid }

    context "with an invalid url" do

      subject { FactoryGirl.build(:link, url: 'foo') }

      it { is_expected.to_not be_valid }

    end

  end

end
