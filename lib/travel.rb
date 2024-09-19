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
    puts "Path: #{path}"
  end

  def find_path(start, finish, path = [start], visited = Set.new)
    return path if start == finish

    visited << start

    current = random_cell

    if @move_validator.valid_knight_move?(start, current) && !@board.contains_red_circle?(
      current
    ) && !visited.include?(current)

      @board.update_board(current)
      path << current

      find_path(current, finish, path, visited)
    else
      find_path(start, finish, path, visited)
    end
  end

  private

  def random_cell
    cell_one = ('a'...'h').to_a.sample
    cell_two = rand(1..8)
    [cell_one, cell_two]
  end
end
