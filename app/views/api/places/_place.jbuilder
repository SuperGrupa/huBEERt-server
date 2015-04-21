json.extract! place, :id, :name, :description, :phone, :email
json.partial! 'places/address', place: place unless place.address.nil?
json.partial! 'places/opening_hours', place: place unless place.opening_hours.nil?
