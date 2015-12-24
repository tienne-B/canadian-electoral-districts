#! /usr/bin/ruby
# Script to separate geojson collection to a file for each district. The geojson file must be already created from the SHAPE file provided.
require 'rubygems'
require 'fileutils'
require 'json'

ROOT = File.expand_path("../", File.dirname(__FILE__))
year = 2013

def write(destination, data)
  File.open(destination, "w") { |file| file.write data.to_json }
end

# Parse JSON and split each district into its own file
data = JSON.parse File.open("#{year}.geojson").read

data["features"].each do |district|
  ridingID = district["properties"]["FEDNUM"]
  puts "Processing #{ridingID}..."
  file = "#{year}/#{ridingID}.geojson"
  write(file, district)
end
