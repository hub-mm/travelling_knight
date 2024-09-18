# board.rb
# frozen_string_literal: true

require_relative 'move_validator'

class Board
  BOARD_SIZE = 8

  BLACK_SQUARE = "\u2B1B"
  WHITE_SQUARE = "\u2B1C"
  RED_CIRCLE = "\u2B55"

  def initialize
    @matrix = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, WHITE_SQUARE) }
    @move_validator = MoveValidator.new
    @display = display
  end

  def update_board(start = [], finish = [])
    breakdown_move(start, finish)

    @move.each do |cell|
      raise ArgumentError, 'Invalid cell input.' unless valid_cell?(cell[0]) && valid_cell?(cell[1])
    end

    place_red_circle(@start_pos)
    place_red_circle(@finish_pos) unless finish.empty?

    display
  end

  def valid_move?(start = [], finish = [])
    breakdown_move(start, finish)

    @move_validator.valid_knight_move?(start, finish)
  end

  private

  def breakdown_move(start = [], finish = [])
    @start_pos = @move_validator.parse_postition(start)
    @finish_pos = @move_validator.parse_postition(finish) unless finish.empty?
    @move = finish.empty? ? [@start_pos] : [@start_pos, @finish_pos]
  end

  def valid_cell?(cell)
    raise ArgumentError, 'Invalid cell input.' if cell.nil?

    cell >= 0 && cell <= BOARD_SIZE
  end

  def place_red_circle(pos)
    @matrix[8 - pos[1]][pos[0]] = RED_CIRCLE
  end

  def black_cells(num = 0)
    until num == BOARD_SIZE

      if num.even?
        [1, 3, 5, 7].each { |i| @matrix[num][i] = BLACK_SQUARE unless @matrix[num][i] == RED_CIRCLE }
      else
        [0, 2, 4, 6].each { |i| @matrix[num][i] = BLACK_SQUARE unless @matrix[num][i] == RED_CIRCLE }
      end

      num += 1
    end
  end

  def display
    black_cells
    num = 9

    puts

    @matrix.each do |row|
      puts "#{num -= 1}  #{row.join}"
    end

    puts "\n   A B C D E F G H"
  end
end
