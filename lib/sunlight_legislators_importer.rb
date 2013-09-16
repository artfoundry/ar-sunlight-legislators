require 'csv'
require_relative '../app/models/politician.rb'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    data = {}
    csv.each do |row|
      row.each do |field, value|
        if field == "title" || field == "firstname" || field == "lastname" || field == "name_suffix" || field == "party" || field == "state" || field == "in_office" || field == "gender" || field == "phone" || field == "fax" || field == "website" || field == "webform" || field == "twitter_id" || field == "birthdate"
          data[field] = value
        end
      end
      p data
      Politician.create!(data)
    end
  end
end

# SunlightLegislatorsImporter.import("db/data/legislators.csv")

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
