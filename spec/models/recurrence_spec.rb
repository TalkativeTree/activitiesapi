require 'spec_helper'

describe Recurrence do
  subject { recurrence }

  ["start_date", "stop_date", "pattern", "activity_id"].each do |attribute|
    context "#{attribute}: nil valid?" do
      let(:recurrence) { build :recurrence, "#{attribute}".to_sym => nil }
      it { recurrence.valid?.should be_false }
    end
  end

  context "valid attributes" do
    let(:recurrence) { build :recurrence }
    it { recurrence.valid?.should be_true }
  end


  context ".build_from_activity" do
    it "generates appropriate recurring activities" do
      @activity = build :activity, id: 1
      Recurrence.any_instance.expects(:create_activities!).once
      Recurrence.any_instance.expects(:update_primary_activity).once
      recurrence = Recurrence.build_from_activity @activity, "2014/01/15", "2014/01/25", 1
    end
  end

  context "#set_occurrences!(1)" do
    let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/01/17"}
    
    it "@occurences = 2" do
      recurrence.occurrences.should == 2
    end
  end

  context "#date_increment(n)" do
    context "daily" do
      let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/01/17", pattern: 1}
      it { recurrence.date_increment(2).should == recurrence.start_date + 2.days }
    end

    context "weekly" do
      let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/02/17", pattern: 2}
      it { recurrence.date_increment(2).should == recurrence.start_date + 2.weeks }
    end

    context "monthly" do
      let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/02/17", pattern: 3}
      it { recurrence.date_increment(2).should == recurrence.start_date + 2.months }
    end
  end

  context "#create_activities!" do
    context "self.pattern == 1" do

      let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/01/17"}
      let(:activity) { build :activity, id: 1}

      before do 
        recurrence.create_activities! activity
      end

      it "self.activities.first.day == 15 " do
        recurrence.activities.first.date.day.should == 15
      end

      it "self.activities.last.day == 16 " do
        recurrence.activities.last.date.day.should == 16
      end
    end

    context "self.pattern == 2" do

      let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/03/17", pattern: 2}
      let(:activity) { build :activity, id: 1}

      before do 
        recurrence.create_activities! activity
      end

      it "self.activities.first.date.cweek == 3" do
        recurrence.activities.first.date.cweek.should == recurrence.start_date.cweek
      end

      it "self.activities.last.date.cweek == 11" do
        recurrence.activities.last.date.cweek.should == recurrence.stop_date.cweek - 1 
      end
    end

    context "self.pattern == 3" do
      let(:recurrence) { create :recurrence, start_date: "2014/01/15", stop_date: "2014/03/17", pattern: 3}
      let(:activity) { build :activity, id: 1}

      before do 
        recurrence.create_activities! activity
      end

      it "self.activities.first.date.month == 1" do
        recurrence.activities.first.date.month.should == 1
      end

      it "self.activities.last.date.month == 2" do
        recurrence.activities.last.date.month.should == recurrence.stop_date.month - 1 
      end
    end

  end
end
