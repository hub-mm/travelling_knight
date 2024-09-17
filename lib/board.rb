# board.rb
# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow

class Board
  def initialize
    @matrix = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, WHITE_SQUARE) }
    @display = display
  end

  BOARD_SIZE = 8

  BLACK_SQUARE = "\u2B1B"
  WHITE_SQUARE = "\u2B1C"

  def black_cells(num = 0)
    until num == BOARD_SIZE

      if num.even?
        [1, 3, 5, 7].each { |i| @matrix[num][i] = BLACK_SQUARE unless @matrix[num][i] == '🔴' }
      else
        [0, 2, 4, 6].each { |i| @matrix[num][i] = BLACK_SQUARE unless @matrix[num][i] == '🔴' }
      end

      num += 1
    end
  end

  def display
    black_cells
    num = 8

    puts

    @matrix.each do |row|
      puts "#{num -= 1}  #{row.join}"
    end

    puts "\n   A B C D E F G H"
  end

  def change_board(cell_one, cell_two)
    @matrix[7 - cell_one][cell_two] = '🔴'
    display
  end
end
