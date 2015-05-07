json.extract! place, :id, :name, :hidden
json.address do
    json.number place.address.number
    json.street place.address.street.name
    json.city   place.address.street.district.city.name
end
