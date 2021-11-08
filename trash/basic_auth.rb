require 'net/http'
require 'net/https'
require 'uri'

USER = "LyleiLanar"
REPO = "my-ruby-adventure"

uri = URI("https://api.github.com/repos/#{USER}/#{REPO}")

Net::HTTP.start(uri.host, uri.port,
                :use_ssl => uri.scheme == 'https',
                :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

  request = Net::HTTP::Get.new uri.request_uri
  request.basic_auth 'LyleiLanar', 'Synae&Decrii07'

  response = http.request request # Net::HTTPResponse object

  puts response
  puts response.body
end
