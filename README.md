### Requirements List

  - activity = Activity.create title: "surfing", vendor: "honey badger surf co"

  #### Ability to 
  - CRUD Activity Model
  - Check Activity availability over a range, ex starting 10/1 to 10/5, how many times is surfing offered?
  - Check Activity avail within a day, ie, on the 15th, how many cooking events offered? 
  - Create Booking against activity.
  - Track and update availibility of slots in an Activity
  #### Tests, Tests, Tests.

### API Strategy

  - using rabl and rails-api to create a lightweight api, no front, using rspec/zeus/guard to test everything.

### Config Steps

```
  bundle install
  rake db:create
  rake parallel:create
  rake parallel:prepare
```

### Running the test suite

  -  json endpoints are all accesible from a browser.

```
  zeus start
  bundle exec guard
```

#### not necessary to init app, background on guard/zeus setup
  - zeus/guard bdd setup 
  - http://jacubeit.com/blog/2013/08/31/rails-4-bdd-setup/
