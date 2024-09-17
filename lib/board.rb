# board.rb
# frozen_string_literal: true

class Board
  def initialize
    @matrix = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, "\u2B1C") }
    @display = display
  end

  BOARD_SIZE = 8

  def display
    num = 8

    puts
    @matrix.each do |row|
      puts "#{num -= 1} #{row.join}"
    end

    puts "  A B C D E F G H\n\n"
  end

  def change_board(cell_one, cell_two)
    @matrix[7 - cell_one][cell_two] = "\u2B1B"
    display
  end
end

test = Board.new
test.change_board(2, 5)
test.change_board(3, 3)
