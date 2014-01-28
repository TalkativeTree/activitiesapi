require 'spec_helper'

API_TOKEN=12345
NEW_ACTIVITY = {title: "climbing", vendor: "honey badger inc", date: "2014/06/01", start_time: "13:00", price: 2200, capacity: 4}
NIL_ACTIVITY = {title: nil, vendor: nil}

describe "Activities API" do
  context "v1" do

    context "GET /activities/:id" do
      before do
        create :activity, id: 2, date: "2014/10/16"
        get '/api/v1/activities/2.json'
      end

      it "returns specified object" do
        expect(json.length).to eq 1
      end

      it "Activitity returns title, vendor, date, start_time and price" do
        ["title", "vendor", "date", "start_time", "price", "id"].each do |attribute|
          expect(json["activity"]["#{attribute}"].nil? ).to be_false
        end
      end
    end

    context "GET /activities" do
      before do
        2.times {|n| create :activity}
        get '/api/v1/activities.json'
      end

      #pagination would be nice once the bulk of the features are built
      it "sends Activities" do
        expect(json.length).to eq 2
      end

    end

    context "GET /activities?range=true&start=2014/10/15&stop=2014/11/15" do
      # there is some kind of error handling problem here
      before do
        (6..8).to_a.each do |n|
          create :activity, date: "2014/0#{n}/10"
        end
      end

      it "returns all activies for the given range" do
        get "/api/v1/activities.json", {range: true, start: "2014/06/09", stop: "2014/07/15"}
        expect(json.length).to eq 2
      end

      it "correctly formed request, status: 201" do
        get "/api/v1/activities.json", {range: true, start: "2014/06/09", stop: "2014/07/15"}
        expect(response.status).to eq 201
      end
      
      it "correct request but bad params, status: 206" do
        get "/api/v1/activities.json", {range: true, start: "somethingelse", stop: "2014/07/15"}
        expect(response.status).to eq 206
      end
    end

    context "POST /activities" do

      context "unauthorized requests" do
        it "response status '401'" do
          post '/api/v1/activities.json'
          expect(response.status).to eq 401
        end
      end

      context "authorized requests" do
        context "correctly formed" do
          before do
            post '/api/v1/activities.json', token: API_TOKEN, activity: NEW_ACTIVITY
          end

          it "response status '201'" do
            expect(response.status).to eq 201
          end

          it "responds with the created object" do
            ["title", "vendor", "date", "start_time", "price", "id"].each do |attribute|
              expect(json["activity"]["#{attribute}"].nil? ).to be_false
            end
          end
        end

        context "malformed" do
          before do
            post '/api/v1/activities.json', token: API_TOKEN, activity: NIL_ACTIVITY
          end

          it "response status '400'" do
            expect(response.status).to eq 400
          end
        end
      end

    end


    context "PUT /activities/:id" do
      context "unauthorized requests" do
        it "response status '401'" do
          post '/api/v1/activities.json'
          expect(response.status).to eq 401
        end
      end

      context "authorized requests" do
        before do
          @activity = create :activity
        end

        context "correctly formed" do
          it "updates and returns activity" do
            expect(Activity.find(@activity.id).title).to eq "Surfing"
            put "/api/v1/activities/#{@activity.id}.json", token: API_TOKEN, activity: NEW_ACTIVITY
            expect(Activity.find(@activity.id).title).to eq "climbing"
            expect(response.status).to eq 200
          end
        end

        context "malformed" do
          it "returns status: 400" do
            put "/api/v1/activities/#{@activity.id}.json", token: API_TOKEN, activity: NIL_ACTIVITY
            expect(response.status).to eq 400
          end
        end

      end
    end


    context "DELETE /activities/:id" do
      context "unauthorized requests" do
        it "response status '401'" do
          delete '/api/v1/activities/1.json'
          expect(response.status).to eq 401
        end
      end

      context "authorized requests" do
        before do
          @activity = create :activity
        end

        it "destroys requested activty" do
          delete "/api/v1/activities/#{@activity.id}.json", token: API_TOKEN
          expect(response.status).to eq 200
        end

      end
    end

  end
end
