# frozen_string_literal: true
require_relative 'Controller'
require_relative 'Repo'
require_relative 'Pull'
require_relative 'Commit'
require_relative 'File'

# cmt = CommitProcessor.new
# cmt.process_commit

rails = Repo.new('rails', 'rails')
# puts rails.get_pulls_numbers
# rails.get_pulls.each { |pull| puts pull.get_title }
# rails.get_pulls.each { |pull| pull.get_commits.each { |commit| puts commit.get_sha } }
#

# Puts all file names of a pull request!
# rails.get_pull_by_index(10).get_all_commited_files.each do |file|
#   puts file.filename
# end

# Puts all redundant files of pull request
# puts 'Redundant files: '
# rails.get_pulls.each do |pull|
#   puts pull.get_title
#   pull.get_redundant_files_in_commits.each do |file|
#     puts "\t- #{file.get_filename}"
#     #puts file.get_modified_rows
#   end
# end

rails.get_all_redundant_commits_in_pulls

# print rails.get_pull_by_index(10).get_title
# print ": \n"
# rails.get_pull_by_index(10).get_multiaffected_files.each do |key, value|
#   print key.get_filename
#   puts " #{value}"
# end

# rails.get_pulls.each do |pull|
#   #puts pull.get_title
#   pull.get_multiaffected_files.each do |key, value|
#     print key.get_filename
#     puts "#{value} "
#   end
# end

