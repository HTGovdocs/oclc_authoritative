require 'mongo'
require 'dotenv'

module OclcAuthoritative
  Dotenv.load
  @@mc = Mongo::Client.new([ENV['mongo_host']+':'+ENV['mongo_port']],
                           :database => ENV['oclc_db'])
  def resolve_oclc(alleged_oclc)
    if (resolved = @@mc[:oclc_authoritative].find(duplicates: alleged_oclc)).count > 0
      resolved.collect {|r| r[:oclc].to_i}
    else
      [alleged_oclc.to_i]
    end
  end
end

