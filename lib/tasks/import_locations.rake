# frozen_string_literal: true

task import_locations: :environment do
  require 'json'

  file = File.read(File.join(Rails.root, 'lib', 'tasks', 'city.list.json'))
  locations_hash = JSON.parse(file)
  locations = []
  locations_hash.each do |row|
    locations << Location.new(api_id: row['id'],
                              name: row['name'],
                              country: row['country'],
                              latitude: row['coord']['lat'],
                              longitude: row['coord']['lat'])
  end
  Location.import locations, batch_size: 1000
end
