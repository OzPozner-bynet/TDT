json.array!(@locationtypes) do |locationtype|
  json.extract! locationtype, :id, :name, :icon_id, :icon_url, :insideR, :nearR
  json.url locationtype_url(locationtype, format: :json)
end
