require 'rails_helper'

RSpec.describe Link, :type => :model do

  context "built" do

    subject { FactoryGirl.build(:link) }

    it { is_expected.to be_valid }

    context "without a url" do

      subject { FactoryGirl.build(:link, url: nil) }

      it { is_expected.to_not be_valid }

    end

  end

end
