require 'mongo'
require 'dotenv'
require 'pp'

Dotenv.load

Mongo::Logger.logger.level = ::Logger::FATAL

@mc = Mongo::Client.new([ENV['mongo_host']+':'+ENV['mongo_port']], :database => 'htgd' )
count = 0 

fin = open(ARGV.shift, 'r')
fin.each do | line |
  count += 1
  o, dupes = line.chomp.split(/:/)
  next if !dupes
  dupes = dupes.split('|').map(&:strip).map(&:to_i)
  rec = {}
  rec[:oclc] = o.to_i
  rec[:dupes] = dupes

  @mc[:oclc_authoritative].insert_one({:oclc => o, :duplicates => dupes})

  if count % 10000 == 0
    print "#{count}\r"
    $stdout.flush
  end
end

