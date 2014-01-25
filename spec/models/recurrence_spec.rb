require 'spec_helper'

describe Recurrence do
  subject { recurrence }

  ["start_date", "stop_date", "pattern", "activity_id"].each do |attribute|
    context "#{attribute}: nil valid?" do
      let(:recurrence) { FactoryGirl.build :recurrence, "#{attribute}".to_sym => nil}
      it { recurrence.valid?.should be_false}
    end
  end

  context "valid attributes" do
    let(:recurrence) { FactoryGirl.build :recurrence}
    it { recurrence.valid?.should be_true}
  end
end
