require 'spec_helper'

describe User do
  subject { user }

  ["name"].each do |attribute|
    context "#{attribute}: nil valid?" do
      let(:user) { FactoryGirl.build :user, "#{attribute}".to_sym => nil}
      it { user.valid?.should be_false}
    end
  end

  context "valid attributes" do
    let(:user) { FactoryGirl.build :user}
    it { user.valid?.should be_true}
  end

end
