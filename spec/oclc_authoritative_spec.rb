require 'dotenv'
require 'oclc_authoritative'

Dotenv.load
RSpec.describe OclcAuthoritative do
  include OclcAuthoritative
  it "retrieves the correct OCLC" do
    expect(resolve_oclc(38)).to eq([38])
    expect(resolve_oclc(812424058)).to eq([812424058])
  end
end
