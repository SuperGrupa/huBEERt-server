json.extract! place, :id, :name, :description, :phone, :email
json.partial! 'places/address', place: place
json.partial! 'places/opening_hours', place: place
