# board.rb
# frozen_string_literal: true

class Board
  def initialize
    @matrix = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, WHITE_SQUARE) }
    @display = display
  end

  BOARD_SIZE = 8

  BLACK_SQUARE = "\u2B1B"
  WHITE_SQUARE = "\u2B1C"
  RED_CIRCLE = "\u2B55"

  def change_board(cell_two, cell_one)
    cell_two = letter_to_number(cell_two)

    raise ArgumentError, 'Invalid cell input.' unless valid_cell?(cell_one) && valid_cell?(cell_two)

    @matrix[8 - cell_one][cell_two] = RED_CIRCLE

    display
  end

  private

  def valid_cell?(cell)
    raise ArgumentError, 'Invalid cell input.' if cell.nil?

    cell >= 0 && cell < BOARD_SIZE
  end

  def letter_to_number(cell_two)
    small_cell_two = cell_two.downcase.to_sym

    change = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    change[small_cell_two]
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
