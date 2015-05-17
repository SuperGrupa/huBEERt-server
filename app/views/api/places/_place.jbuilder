json.partial! 'places/basic_info', place: place
json.partial! 'places/address', place: place unless place.address.nil?
json.partial! 'places/opening_hours', place: place unless place.opening_hours.nil?
