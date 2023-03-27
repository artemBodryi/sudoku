require 'matrix' #library for work with matrices
require_relative './sudoku-box.rb'

class Sudoku
  attr_reader :sudoku_string

  ROW_SIGN = '|' 
  COLUMN_SIGN = '-'
  GROUPS_INDEXES =
    [
      { row: 0, col: 0 },
      { row: 0, col: 3 },
      { row: 0, col: 6 },
      { row: 3, col: 0 },
      { row: 3, col: 3 },
      { row: 3, col: 6 },
      { row: 6, col: 0 },
      { row: 6, col: 3 },
      { row: 6, col: 6 }
  ]

  def initialize(sudoku_string) # initialize the Sudoku object with the given string and arguments
    @sudoku_string = sudoku_string
  end

  def columns # returns the number of columns in the Sudoku
    @columns ||= (0..8).each_with_object([]) do |index, columns_arr|
      columns_arr << SudokuBox.new(matrix.column(index).to_a)
    end
  end

  def rows  # returns the number of rows in the Sudoku
    @rows ||= (0..8).each_with_object([]) do |index, rows_arr| # each row is an array of cells in the Sudoku object with the given index and rows are returned as an array    
      rows_arr << SudokuBox.new(matrix.row(index).to_a)
    end
  end

  def sub_groups # returns the subgroups of the Sudoku
    @sub_groups ||= GROUPS_INDEXES.each_with_object([]) do |group, sub_groups|
      sub_matrix = matrix.minor(group[:row],3,group[:col],3)
      sub_groups << SudokuBox.new(sub_matrix.to_a.flatten)
    end
  end

  def valid? # returns true if the Sudoku is a valid Sudoku string
    valid_sections?(rows) && valid_sections?(columns) && valid_sections?(sub_groups)
  end

  def completed? # returns true if the Sudoku is a completed Sudoku string
    !sudoku_string.include?('0')
  end

  private

  def matrix # returns the matrix of the Sudoku 
    @matrix ||=  begin
      rows = sudoku_string_rows.each_with_object([]) do |row, acc|
        acc << build_matrix_row(row)
      end

      Matrix.rows(rows)
    end
  end

  def sudoku_string_rows # returns the rows of the Sudoku string
    @data ||= begin
                s = sudoku_string.split("\n")
                s.reject { |h| h.include?(COLUMN_SIGN) }
              end
  end

  def build_matrix_row(row_string) # returns the row of the Sudoku string 
    no_separators = row_string.delete!(ROW_SIGN)
    no_separators.split(//).reject { |h| h == " " }
  end

  def valid_sections?(sections) # returns true if the sections are valid
    sections.all?(&:valid?)
  end
end
