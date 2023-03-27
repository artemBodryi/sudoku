require_relative 'lib/validator'

print("Please enter a sudoku validation type (valid, invalid, incomplete): ")
type = gets.chomp
if (type == "valid")
    sudoku_string = File.read("./spec/fixtures/valid_complete.sudoku")
    puts ("#{sudoku_string}")
elsif (type == "invalid")
    print("Choose one of the following options (column, char, row, subgroup, simple):")
    subtype = gets.chomp
    if (subtype == "column")
        sudoku_string = File.read("./spec/fixtures/invalid_due_to_column_dupe.sudoku")
        puts ("#{sudoku_string}")
    elsif (subtype == "char")
        sudoku_string = File.read("./spec/fixtures/invalid_due_to_forbidden_characters.sudoku")
        puts ("#{sudoku_string}")
    elsif (subtype == "row")
        sudoku_string = File.read("./spec/fixtures/invalid_due_to_row_dupe.sudoku")
        puts ("#{sudoku_string}")
    elsif (subtype == "subgroup")
        sudoku_string = File.read("./spec/fixtures/invalid_due_to_subgroup_dupe.sudoku")
        puts ("#{sudoku_string}")
    elsif (subtype == "simple")
        sudoku_string = File.read("./spec/fixtures/simple.sudoku")
        puts ("#{sudoku_string}")
    end
elsif (type == "incomplete")
    sudoku_string = File.read("./spec/fixtures/valid_incomplete.sudoku")
    puts ("#{sudoku_string}")
end
puts Validator.validate(sudoku_string)
