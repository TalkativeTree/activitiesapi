require 'spec_helper'

API_TOKEN=12345
NEW_ACTIVITY = {title: "climbing", vendor: "honey badger inc", date: "2014/06/01", start_time: "13:00", price: 2200, capacity: 4}
describe "Bookings API" do
  context "v1" do
    context "unauthorized requests" do
      it "response status '400'" do
        post '/api/v1/bookings.json'
        expect(response.status).to eq 401
      end
    end

    context "authorized requests" do
      context "correctly formed params" do
        before do
          @activity = create :activity
          @user = create :user
        end

        it "creates a new booking" do
          booking = { activity_id: @activity.id, user_id: @user.id }
          post '/api/v1/bookings.json', token: API_TOKEN, booking: booking
          expect(response.status).to eq 201
        end

      end
    end
  end
end
