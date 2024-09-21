# frozen_string_literal: true

require_relative 'move_validator'

class Board
  BOARD_SIZE = 8

  BLACK_SQUARE = "\u2B1B"
  WHITE_SQUARE = "\u2B1C"
  RED_CIRCLE = "\u2B55"

  def initialize
    @matrix = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    setup_board
    @move_validator = MoveValidator.new
  end

  def update_board(pos)
    x, y = @move_validator.parse_position(pos)
    @matrix[BOARD_SIZE - 1 - y][x] = RED_CIRCLE
  end

  def contains_red_circle?(pos)
    x, y = @move_validator.parse_position(pos)
    @matrix[BOARD_SIZE - 1 - y][x] == RED_CIRCLE
  end

  def display
    puts
    @matrix.each_with_index do |row, index|
      print "#{BOARD_SIZE - index}  "
      row.each do |cell|
        print cell
      end
      puts
    end
    puts "\n   A B C D E F G H"
  end

  private

  def setup_board
    (0...BOARD_SIZE).each do |row|
      (0...BOARD_SIZE).each do |col|
        @matrix[row][col] = if (row + col).even?
                              WHITE_SQUARE
                            else
                              BLACK_SQUARE
                            end
      end
    end
  end
end
