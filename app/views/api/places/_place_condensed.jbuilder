json.basic_info { json.extract! place, :id, :name, :hidden }
json.partial! 'places/address', place: place unless place.address.nil?
