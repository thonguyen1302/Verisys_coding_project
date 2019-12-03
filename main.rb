#!/usr/bin/env ruby
require 'csv'
require 'json'

def csv_to_json(file_path='data/healthprofessionals.csv')
	# Read file csv
	lines = CSV.open(file_path).readlines
	# Remove the header
	keys = lines.delete lines.first
	# Map the lines
	data = lines.map do |values|
		Hash[keys.zip(values)]
	end

	# Process the phone numbers
	data.each do |item|
		phone1 = item['Phone 1 number']
		phone2 = item['Phone 2 number']
		phone3 = item['Phone 3 number']

		unless phone1.nil?
			phone1 = phone1.scan(/\d/).join('')
			phone1 = phone1[1..phone1.length] if phone1.length == 11
			phone1.insert(3, '-')   
			phone1.insert(7, '-')   	
		end
		

		unless phone2.nil?
			phone2 = phone2.scan(/\d/).join('')
			phone2 = phone2[1..phone2.length] if phone2.length == 11
			phone2.insert(3, '-')   
			phone2.insert(7, '-')   	
		end

		unless phone3.nil?
			phone3 = phone3.scan(/\d/).join('')
			phone3 = phone3[1..phone3.length] if phone3.length == 11
			phone3.insert(3, '-')   
			phone3.insert(7, '-')   	
		end

		item['Phone 1 number'] = phone1
		item['Phone 2 number'] = phone2
		item['Phone 3 number'] = phone3
	end

	# Unique data
	data.uniq! {|d| d['License number']}

	# Write JSON file
	File.open("output.json","w") do |f|
	  f.write(JSON.pretty_generate(data))
	end
	
end

# Call function
csv_to_json()
