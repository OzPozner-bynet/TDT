json.extract! gpslocation, :id, :name, :address, :latitude, :longitude, :created_at, :updated_at
json.url gpslocation_url(gpslocation, format: :json)
