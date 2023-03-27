#this class represents a section of pazzle
#number is an instance variable that represents the sections numbers were '0' is empty space

class SudokuBox
    attr_accessor :numbers

  def initialize(numbers) # Initialize a new SudokuBox instance with the given numbers
    @numbers = numbers
  end

  def valid? # check if the box is valid
    (0..8).each do |index|
      item = numbers[index]
      next if item == '0'
      return false if item_invalid?(item)

    end
    true
  end

  def to_s #convert nums to a string
    numbers.to_s
  end

  private

  def item_invalid?(item) #check if the item is invalid
    item_count = numbers.count(item)
    item_count != 1
  end
end
