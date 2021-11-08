require 'github_api'

github = Github.new basic_auth: 'login:password'

puts github.users.followers.list 'LyleiLanar'
puts github.repos 'LyleiLanar'