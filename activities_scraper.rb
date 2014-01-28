require 'rest-client'
require 'pry'
require 'pry-debugger'
require 'json'

API_TOKEN=12345
NEW_ACTIVITY = {title: "climbing", vendor: "honey badger inc", date: "2014/06/01", start_time: "13:00", price: 2200, capacity: 4}
NIL_ACTIVITY = {title: nil, vendor: nil}

activities = JSON.parse RestClient.get "http://localhost:3001/api/v1/activities.json?range=true&start=2014/05/20&stop=2014/06/02"
binding.pry
