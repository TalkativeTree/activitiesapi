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

  context ".valid_query_dates?" do
    context "start_date: invalid date" do
      it "returns false" do
        Activity.valid_query_dates?({start_date: "anyrandomdata"}).should be_false
      end
    end

    context "start_date: invalid date" do
      it "returns false" do
        Activity.valid_query_dates?({start_date: "2014/06/01"}).should be_true
      end
    end

    context "only relevant params gets validated" do
      it "returns true" do
        Activity.valid_query_dates?({random: "anyrandomdata"}).should be_true
      end
    end
  end

  context ".query_by" do
    context "start_date: valid date, end_date: valid date" do
      it "returns all activities given the range" do
        create :activity, date: "2014/06/12"
        create :activity, date: "2014/06/16"
        params = {start_date: "06/12", stop_date: "06/13"}.with_indifferent_access
        Activity.query_by(params).count.should == 1
      end
    end

    context "start_date: valid date, end_date: valid date, activity: 'surfing'" do
      it "returns only actitivies matching the date range and activity" do
        create :activity, date: "2014/06/12", title: "surfing"
        create :activity, date: "2014/06/12", title: "climbing"
        params = {start_date: "06/12", stop_date: "06/13", activity: "climbing"}.with_indifferent_access
        Activity.query_by(params).count.should == 1
      end
    end

    context "date: valid date, activity: 'surfing'" do
      it "returns only actitivies matching the date and activity" do
        create :activity, date: "2014/06/12", title: "surfing"
        create :activity, date: "2014/06/12", title: "climbing"
        params = {date: "06/12", activity: "climbing"}.with_indifferent_access
        Activity.query_by(params).count.should == 1
      end
    end
  end

end
