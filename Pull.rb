class Pull

  require_relative 'Controller'
  require_relative 'Commit'

  def initialize(pull, api)
    @api = api
    @pull = pull
    @commits = []

    api_commits = @api.get_commits_by_pull_id(@pull.number)

    for i in 0...api_commits.length
      @commits.push Commit.new(api_commits[i].sha, @api)
    end
  end

  def get_pull
    @pull
  end

  def get_number
    @pull.number
  end

  def get_title
    @pull.title
  end

  def get_commits
    @commits
  end

  def get_all_commited_files
    all_files = []
    @commits.each do |commit|
      commit.get_files.each do |file|
        all_files.push(file)
      end
    end
    all_files
  end

  def get_redundant_files_in_commits
    #File occurrence
    foc = Hash.new

    files = get_all_commited_files

    files.each do |file|
      if foc.key? file.get_filename
        foc[file.get_filename] += 1
      else
        foc[file.get_filename] = 0
      end
    end

    redundants = []

    foc.each do |key, value|
      if value > 1

        files.each do |file|
          if file.get_filename == key
            redundants.push(file)
          end
        end
      end
    end
    redundants
  end

  def get_multiaffected_files
    redundants = get_redundant_files_in_commits

    file_affected_rows = Hash.new
    multiaffected_files = Hash.new

    redundants.each do |redundant|
      mod_rows = redundant.get_modified_rows

      mod_rows.each do |mod_row|
        if file_affected_rows.key? mod_row
          file_affected_rows[mod_row] += 1
        else
          file_affected_rows[mod_row] = 1
        end
      end

      rows = []

      file_affected_rows.each do |key, value|

        if value > 1
          rows.push key
        end
      end
      multiaffected_files[redundant] = rows
    end

    multiaffected_files

  end
end
