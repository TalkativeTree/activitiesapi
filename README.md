### Requirements List
  Activity Data Model, attributes title: "surfing", vendor: "honey badger surf co"
  CRUD Activity Model
  Ability to check Activity availability over a range, ex starting 10/1 to 10/5, how many times is surfing offered?
  Ability to check Activity avail within a day, ie, on the 15th, how many cooking events offered? 
  Ability to create Booking against activity.
  Ability to track and update availibility of slots in an Activity
  Tests, test, tests.

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
  -  the json endpoints are all accesible from a browswer but there is no front end built

```
  zeus start
  bundle exec guard
```

#### not necessary for setup but background on where guard/zeus info comes from
  - zeus/guard bdd setup 
  - http://jacubeit.com/blog/2013/08/31/rails-4-bdd-setup/
