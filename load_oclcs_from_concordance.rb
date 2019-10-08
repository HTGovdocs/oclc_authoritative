require 'mongo'
require 'dotenv'
require 'pp'

# Note: this doesn't update correctly, as it assumes there are only
# changes in the new file. It will add duplicate "duplicates"

Dotenv.load

Mongo::Logger.logger.level = ::Logger::FATAL

@mc = Mongo::Client.new([ENV['mongo_host']+':'+ENV['mongo_port']], :database => 'htgd' )
count = 0 
num_deleted = 0

fin = open(ARGV.shift, 'r')
fin.each do | line |
  count += 1
  dupe, o = line.chomp.split("\t")
 
  # remove any that were previously authoritative
  res = @mc[:oclc_authoritative].delete_one({:oclc => dupe.to_i})
  num_deleted += res.deleted_count

  # upsert
  @mc[:oclc_authoritative].update_one({:oclc => o.to_i}, 
                                      {"$push" => {:duplicates => dupe.to_i}},
                                      :upsert => true, :safe => true)
  
  if count % 10000 == 0
    print "#{count}\r"
    STDOUT.flush
  end
end
puts "num deleted:#{num_deleted}"

