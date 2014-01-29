object @recurrence
attributes :start_date, :stop_date, :pattern, :occurrences
if @recurrence
  child :activities do
    extends "api/v1/activities/show"
  end
end
