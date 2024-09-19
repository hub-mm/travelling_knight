# travel.rb
# frozen_string_literal: true

require_relative 'board'
require_relative 'move_validator'

class Travel
  def initialize
    @move_validator = MoveValidator.new
    @board = Board.new
  end

  def knight_moves(start = [], finish = [])
    start = [start[0].to_s.downcase, start[1]]
    finish = [finish[0].to_s.downcase, finish[1]]
    @board.update_board(start)
    path = find_path(start, finish)
    if path
      puts "\nPath found: #{path}"
    else
      puts 'No path found.'
    end
  end

  private

  def find_path(start, finish, path = [start], visited = [])
    return path if start == finish

    visited << start

    current = random_cell

    if possible_move_check(start, current, visited)
      path << current

      @board.update_board(current)

      find_path(current, finish, path, visited)
    else
      find_path(start, finish, path, visited)
    end
  end

  def random_cell
    cell_one = ('a'..'h').to_a.sample
    cell_two = rand(1..8)
    [cell_one, cell_two]
  end

  def possible_move_check(start, current, visited)
    @move_validator.valid_knight_move?(start,
                                       current) && !@board.contains_red_circle?(current) && !visited.include?(current)
  end
end
