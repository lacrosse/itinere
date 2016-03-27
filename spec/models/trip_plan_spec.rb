require 'rails_helper'

describe TripPlan do
  subject { trip_plan }

  let(:trip_plan) { FactoryGirl.create :trip_plan }

  it { is_expected.to be_valid }

  describe 'without a title' do
    let(:trip_plan) { FactoryGirl.build :trip_plan, title: '' }

    it { is_expected.not_to be_valid }
  end

  describe '.published' do
    subject { described_class.published }

    let!(:trip_plan_1) { FactoryGirl.create :trip_plan, published: true }
    let!(:trip_plan_2) { FactoryGirl.create :trip_plan }

    it { is_expected.to contain_exactly trip_plan_1 }
  end

  describe '#start_location_lat' do
    subject { trip_plan.start_location_lat }

    it { is_expected.to eq '12' }
  end

  describe '#start_location_lon' do
    subject { trip_plan.start_location_lon }

    it { is_expected.to eq '34' }
  end

  describe '#finish_location_lat' do
    subject { trip_plan.finish_location_lat }

    it { is_expected.to eq '23' }
  end

  describe '#finish_location_lon' do
    subject { trip_plan.finish_location_lon }

    it { is_expected.to eq '45' }
  end

  describe '#generate_alternate_id' do
    subject { trip_plan.generate_alternate_id }

    it { expect { subject }.to change { trip_plan.alternate_id } }
  end
end
