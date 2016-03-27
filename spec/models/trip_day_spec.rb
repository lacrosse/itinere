require 'rails_helper'

describe TripDay do
  subject { trip_day }

  let(:trip_day) { FactoryGirl.create :trip_day }

  it { is_expected.to be_valid }

  describe 'without a date' do
    let(:trip_day) { FactoryGirl.build :trip_day, date: nil }

    it { is_expected.not_to be_valid }
  end

  describe '#title' do
    subject { trip_day.title }

    it { is_expected.to eq "#{trip_day.trip_plan.title} — #{trip_day.date.strftime('%b %e')}" }
  end

  describe '#populate_weather' do
    pending
  end
end
