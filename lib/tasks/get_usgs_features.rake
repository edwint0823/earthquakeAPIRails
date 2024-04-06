# frozen_string_literal: true

namespace :api do
  desc 'Populate Features table using USGS last 30 days data'
  task fetch_data: :environment do
    require 'net/http'
    require 'json'
    begin
      url = URI('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
      response = Net::HTTP.get(url)
      data = JSON.parse(response)
      features = data['features']

      ActiveRecord::Base.transaction do
        features.each do |feature|
          next if Feature.exists?(
            mag: feature['properties']['mag'],
            place: feature['properties']['place'],
            time: Time.at(feature['properties']['time'] / 1000).to_date,
            mag_type: feature['properties']['magType'],
            title: feature['properties']['title']
          )
          next if feature['properties']['title'].nil? || feature['properties']['url'].nil? ||
                  feature['properties']['place'].nil? || feature['properties']['magType'].nil? ||
                  feature['geometry']['coordinates'].nil? || feature['properties']['mag'].nil? ||
                  feature['geometry']['coordinates'][0].nil? || feature['geometry']['coordinates'][1].nil? ||
                  feature['properties']['mag'] < -1.0 || feature['properties']['mag'] > 10.0 ||
                  feature['geometry']['coordinates'][1] < -90.0 || feature['geometry']['coordinates'][1] > 90.0 ||
                  feature['geometry']['coordinates'][0] < -180.0 || feature['geometry']['coordinates'][0] > 180.0

          Feature.create!(
            mag: feature['properties']['mag'],
            place: feature['properties']['place'],
            time: Time.at(feature['properties']['time'] / 1000).to_date,
            url: feature['properties']['url'],
            tsunami: feature['properties']['tsunami'],
            mag_type: feature['properties']['magType'],
            title: feature['properties']['title'],
            longitude: feature['geometry']['coordinates'][0],
            latitude: feature['geometry']['coordinates'][1]
          )
        end
      end
      puts 'Feature table populate successfully'

    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end
