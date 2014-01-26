### Requirements List

  - activity = Activity.create title: "surfing", vendor: "honey badger surf co"

### Ability to 
  - CRUD Activities.
  - Activities can have defined capacity.
  - Activities can have unique prices.
  - Check Activity availability over a range, ie, starting 10/1 to 10/5, how many times is surfing offered?
  - Check Activity avail within a day, ie, on the 15th, how many cooking events offered? 
  - Create Booking against activity.
  - Bookings should not be deleteable by api.
  - Activities have recurrence. 

### API Strategy

  - using rabl and rails-api to create a lightweight api

### Config Steps

```
  bundle install
  rake db:create
  rake parallel:create
  rake parallel:prepare
```

### Running the test suite

  -  json endpoints are all accessible from a browser.

```
  zeus start
  bundle exec guard
```

#### not necessary to init app, background on guard/zeus setup
  - zeus/guard bdd setup 
  - http://jacubeit.com/blog/2013/08/31/rails-4-bdd-setup/

#### Areas to Improve
  - Recurrence's don't absorb the model Activity object into the recurrence series.
  - Lots of funcionality could be built tied to managing how activities get added, removed or manipulated that are part of a Recurrence. 
