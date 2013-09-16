require_relative '../db/config'
require_relative 'models/politician'

puts "Senators:"
sen = Politician.where(state: 'CA', title: 'Sen')
sen.each {|pol| puts "#{pol.firstname} #{pol.lastname} (#{pol.party})"}
puts ""
puts "Representatives:"
rep = Politician.where(state: 'CA', title: 'Rep')
rep.each {|pol| puts "#{pol.firstname} #{pol.lastname} (#{pol.party})"}

male_sen = Politician.where(gender: 'M', title: 'Sen', in_office: 1)
puts "Male Sentators: #{male_sen.length} (#{male_sen.length}%)"

male_rep = Politician.where(gender: 'M', title: 'Rep', in_office: 1)
total_reps = Politician.where(title: 'Rep', in_office: 1).count
puts "Male Representatives: #{male_rep.length} (#{((male_rep.length.to_f/total_reps.to_f) * 100).to_i}%)"


states = Politician.where(in_office: 1).order("title DESC").order("state").group("state", "title").count
states.each do |state|
  if state[0][1] == "Sen"
    print "#{state[0][0]}: #{state[1]} Senators, "
  elsif state[0][1] == "Rep"
    print "#{state[1]} Representative(s)\n"
  end
end


puts Politician.where(title: 'Rep').count
puts Politician.where(title: 'Sen').count

poldelete = Politician.where(in_office: 0)
poldelete.destroy_all

puts Politician.where(title: 'Rep').count
puts Politician.where(title: 'Sen').count