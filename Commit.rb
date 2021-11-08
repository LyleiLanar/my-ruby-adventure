class Commit

  require_relative 'Controller'
  require_relative 'File'

  def initialize(sha, api)
    @api = api
    @commit = @api.get_commit_by_id(sha)
    @files = []

    for i in 0...@commit.files.length
      @files.push File.new(@commit.files[i], @api)
    end

  end

  def get_sha()
    @commit.sha
  end

  def get_files()
    @files
  end

end