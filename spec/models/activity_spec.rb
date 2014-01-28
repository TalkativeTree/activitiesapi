require 'spec_helper'

ACTIVITY = {"title" =>  "climbing", "vendor" => "honey badger inc", "date" => "2014/06/01", "start_time" => "13:00", "price" => 2200, "capacity" => 4}

describe Activity do
  subject { activity }

  context ".required_attributes" do
    it "['title', 'vendor', 'date', 'start_time', 'price', 'capacity']" do
      Activity.required_attributes.should == ['title', 'vendor', 'date', 'start_time', 'price', 'capacity']
    end
  end

  Activity.required_attributes.each do |attribute|
    context "#{attribute}: nil valid?" do
      let(:activity) { FactoryGirl.build :activity, "#{attribute}".to_sym => nil}
      it { activity.valid?.should be_false}
    end
  end

  context "valid attributes" do
    let(:activity) { FactoryGirl.build :activity }
    it { activity.valid?.should be_true}
  end

  context "responds to recurrence_id" do
    let(:activity) { FactoryGirl.build :activity }
    it { activity.respond_to?(:recurrence_id).should be_true}
  end

  context ".build_from_json" do
    it "builds a new Activity." do
      @activity = Activity.build_from_json ACTIVITY
      @activity.valid?.should be_true
    end
  end

  context ".update_from_json!" do
    it "updates an existing Activity." do
      existing_activity = create :activity
      @activity = Activity.update_from_json! existing_activity.id, ACTIVITY
      expect(@activity).to eq true
      expect(Activity.find(existing_activity.id).title).to eq "climbing"
    end
  end

  context "#at_capacity?" do
    before do
      @activity = create :activity
    end

    context "Activity.bookings.count == self.capacity" do
      it "returns true" do
        4.times {|n| create :booking, activity_id: @activity.id }
        @activity.at_capacity?.should == true
      end
    end

    context "Activity.bookings.count < self.capacity" do
      it "returns true" do
        @activity.at_capacity?.should == false
      end
    end
  end

  context "#oversubscribed?" do
    before do
      @activity = create :activity
    end

    context "Activity.bookings.count > self.capacity" do
      it "returns true" do
        6.times {|n| create :booking, activity_id: @activity.id }
        @activity.oversubscribed?.should == true
      end
    end

    context "Activity.bookings.count < self.capacity" do
      it "returns true" do
        @activity.oversubscribed?.should == false
      end
    end
  end

  context ".by_range" do
    it "returns records within date range" do
      create :activity, date: "2014/06/30"
      create :activity, date: "2014/07/30"
      @activities = Activity.by_range "2014/06/01", "2014/06/30"
      Activity.count.should == 2
      @activities.count.should == 1
    end

    it "returns nil if malformed params" do
      @activities = Activity.by_range "non-date", false
      @activities.should be_nil
    end

    it "gracefully handles poorly formed dates" do
      # this seems like a poor test
      # and what expectation format should I be using ? 
      create :activity, date: "2014/06/30"
      @activities = Activity.by_range("06/12", "07/12").should_not raise_error
      @activities = Activity.by_range("06/12", "07/12").length.should == 1
    end


  end

end
