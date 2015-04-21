json.address do
    json.city   place.address.street.district.city.name
    json.street place.address.street.name
    json.number place.address.number
end