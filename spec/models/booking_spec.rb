require 'spec_helper'

describe Booking do
  subject { booking }

  ["user_id", "activity_id"].each do |attribute|
    context "#{attribute}: nil valid?" do
      let(:booking) { FactoryGirl.build :booking, "#{attribute}".to_sym => nil}
      it { booking.valid?.should be_false}
    end
  end

  context "valid attributes" do
    let(:booking) { FactoryGirl.build :booking}
    it { booking.valid?.should be_true}
  end

  context ".build_from_json" do
    it "builds a new Booking" do
      new_booking = { :"activity_id" => 1, :"user_id" => 1}
      booking = Booking.build_from_json new_booking
      booking.valid?.should be_true
    end
  end

end
