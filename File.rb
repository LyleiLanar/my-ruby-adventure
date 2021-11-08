class File

  def initialize(file, api)
    @file = file
    @api = api
  end

  def get_file
    @file
  end

  def get_patch
    @file.patch
  end

  def get_filename
    @file.filename
  end

  def get_modified_rows
    patch_rows = @file.patch.split("\n")
    modified_rows = []
    added_row_counter = 0
    removed_row_counter = 0
    added_start_row = patch_rows[0].split(",")[1].split("+")[1].to_i
    removed_start_row = patch_rows[0].split(",")[0].split("-")[1].to_i
    for i in 1...patch_rows.length
      #puts patch_rows[i][0,2]
      if patch_rows[i][0, 2] == "@@"
        added_start_row = patch_rows[i].split(",")[1].split("+")[1].to_i
        removed_start_row = patch_rows[i].split(",")[0].split("-")[1].to_i
        added_row_counter = -1
        removed_row_counter = -1
      elsif patch_rows[i][0] == "+"
        #modified_rows.push "+#{added_start_row + added_row_counter}";
        modified_rows.push added_start_row + added_row_counter;
        removed_row_counter -= 1
      elsif patch_rows[i][0] == "-"
        #modified_rows.push "-#{removed_start_row + removed_row_counter}";
        modified_rows.push removed_start_row + removed_row_counter;
        added_row_counter -= 1
      end

      added_row_counter += 1
      removed_row_counter += 1

    end
    modified_rows.uniq
  end

end