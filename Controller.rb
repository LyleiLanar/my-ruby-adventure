class Controller

  require 'json'
  require 'uri'
  require 'net/http'
  require 'net/https'

  def initialize(user, repo)
    @user = user
    @repo = repo
  end

  #Your own gitHub Personal Authentication Token
  TOKEN = 'token'

  AUTH_NAME = "login"
  AUTH_PSWD = "pswd"

  def get_json_from_api(uri_str)

    uri = URI(uri_str)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(uri_str)
    request['Authorization'] = "token #{TOKEN}"
    http.request(request).body
  end

  def get_object_from_api(uri)
    JSON.parse(get_json_from_api(uri), object_class: OpenStruct)
  end

  #You have to add the "user,repository" string as the arguments.
  def get_repository_by_names()
    uri = "https://api.github.com/repos/#{@user}/#{@repo}"
    get_object_from_api(uri)
  end

  def get_pulls_by_repo_names()
    uri = "https://api.github.com/repos/#{@user}/#{@repo}/pulls?per_page=50"
    get_object_from_api(uri)
  end

  def get_commits_by_pull_id(pull_id)
    uri = "https://api.github.com/repos/#{@user}/#{@repo}/pulls/#{pull_id}/commits"
    get_object_from_api(uri)
  end

  def get_commit_by_id(commit_sha)
    uri = "https://api.github.com/repos/#{@user}/#{@repo}/commits/#{commit_sha}"
    get_object_from_api(uri)
  end

  # There were some problems with the Authentication... These are my test api calling functions.
  # There was only 60 api calling possibilities. And I reached that so fast.

  # def get_json_from_api_original(uri_str)
  #   uri = URI(uri_str)
  #   res = Net::HTTP.get_response(uri)
  #   res.body if res.is_a?(Net::HTTPSuccess)
  # end

  # def get_json_from_api2(uri_str)
  #   uri = URI(uri_str)
  #
  #   Net::HTTP.start(uri.host, uri.port,
  #                   :use_ssl => uri.scheme == 'https',
  #                   :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
  #
  #     request = Net::HTTP::Get.new uri.request_uri
  #     request.basic_auth AUTH_NAME, AUTH_PSWD
  #
  #     response = http.request request # Net::HTTPResponse object
  #     response.body
  #   end
  # end

end