require 'spec_helper'

API_TOKEN=12345
RECURRENCE= { start_date: "2014/06/01", stop_date: "2014/06/05", pattern: 1}
NIL_RECURRENCE= { start_date: "2014/06/01", stop_date: nil, pattern: 1}
NEW_ACTIVITY = {title: "climbing", vendor: "honey badger inc", date: "2014/06/01", start_time: "13:00", price: 2200, capacity: 4}
NIL_ACTIVITY = {title: nil, vendor: nil}

describe "Activities API" do
  context "v1" do
    context "unauthorized requests" do
      it "response status '400'" do
        post '/api/v1/recurrences.json'
        expect(response.status).to eq 401
      end
    end

    context "authorized requests" do
      context "correctly formed params" do
        before do
          post '/api/v1/recurrences.json', token: API_TOKEN, activity: NEW_ACTIVITY, recurrence: RECURRENCE
        end
        it "creates a recurrence and relevant activities" do
          expect(response.status).to eq 201
        end

        it "returns the created Recurrence" do
          expect(json.has_key?("recurrence")).to eq true
          expect(json["recurrence"]["start_date"]).to eq "2014-06-01"
        end

        it "returns Recurence.activities" do
          expect(json["recurrence"]["activities"].length).to eq 4
        end
      end

      context "mal formed params" do
        it "response status '400'" do
          post '/api/v1/recurrences.json', token: API_TOKEN, activity: NEW_ACTIVITY, recurrence: NIL_RECURRENCE
          expect(response.status).to eq 400
        end
      end

    end

  end
end
