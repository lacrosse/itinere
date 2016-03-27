require 'rails_helper'

describe User do
  subject { user }

  let(:user) { FactoryGirl.create :user }

  it { is_expected.to be_valid }
end
