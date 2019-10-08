require 'dotenv'
require 'oclc_authoritative'
require 'benchmark'

Dotenv.load
RSpec.describe OclcAuthoritative do
  include OclcAuthoritative
  it "retrieves the correct OCLC" do
    expect(resolve_oclc(38)).to eq([38])
    expect(resolve_oclc(812424058)).to eq([812424058])
    expect(resolve_oclc(1000012977)).to eq([940821419])
  end

  it "isn't incredibly slow" do
    test_oclcs = File.readlines('spec/data/random_oclcs_10000.txt')
    Benchmark.bmbm do |x|
      x.report('resolve_oclc') do
        test_oclcs.each do |oclc|
          o = resolve_oclc(oclc.to_i)
        end
      end
    end
  end
end
