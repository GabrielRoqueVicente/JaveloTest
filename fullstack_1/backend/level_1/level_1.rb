require 'rubygems'
require 'json'
require 'pp'

json = File.read('data/input.json')
obj = JSON.parse(json)

objectives = obj["objectives"]
progressRecords = obj["progress_records"]


def progressPercent(target,start,value )
	progress = value*100/(target-start)
	return progress
end
newProgressRecords = []

progressRecords.each do |record|
	recordId = record["id"]
	objectives.each do |objective|
		if objective["id"] == recordId
			progress = progressPercent(objective["target"], objective["start"], record["value"])
			newProgressRecords << {id: recordId, progress: progress} 
		end		
	end
end
newProgressRecords = {progress_records: newProgressRecords}

File.open("output.json","w") do |f|
  f.write(newProgressRecords.to_json)
end