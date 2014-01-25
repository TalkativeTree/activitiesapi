require 'spec_helper'

describe Activity do
  subject { activity }

  ["title", "vendor", "date", "start_time", "price" ].each do |attribute|
    context "#{attribute}: nil valid?" do
      let(:activity) { FactoryGirl.build :activity, "#{attribute}".to_sym => nil}
      it { activity.valid?.should be_false}
    end
  end

  context "valid attributes" do
    let(:activity) { FactoryGirl.build :activity }
    it { activity.valid?.should be_true}
  end

end
