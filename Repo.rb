class Repo

  require_relative 'Controller'
  require_relative 'Pull'

  def initialize(user, repo_name)
    @api = Controller.new(user, repo_name)
    @pulls = []
    api_pulls = @api.get_pulls_by_repo_names
    for i in 0...api_pulls.length
      @pulls.push Pull.new(api_pulls[i], @api)
    end
    #@api.get_pulls_by_repo_names(user, repo_name).each { |pull| @pulls.push[pull] }
  end

  def get_pulls
    @pulls
  end

  def get_pulls_numbers()
    pull_numbers = []
    for i in 0...@pulls.length
      pull_numbers.push(@pulls[i].get_number)
    end
    pull_numbers
  end

  def get_pull_by_index(index)
    @pulls[index]
  end

  def get_all_redundant_commits_in_pulls

    @pulls.each do |pull|
      print pull.get_title
      print ": \n"
      pull.get_multiaffected_files.each do |key, value|
        print key.get_filename
        puts " #{value}"
      end
      puts
    end
  end
end