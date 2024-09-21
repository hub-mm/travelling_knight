# frozen_string_literal: true

require_relative 'board'
require_relative 'move_validator'

class Travel
  KNIGHT_MOVES = [
    [-2, -1], [-1, -2], [1, -2], [2, -1],
    [2, 1], [1, 2], [-1, 2], [-2, 1]
  ].freeze

  def initialize
    @move_validator = MoveValidator.new
    @board = Board.new
  end

  def knight_moves(start = [], finish = [])
    start = [start[0].to_s.downcase, start[1]]
    finish = [finish[0].to_s.downcase, finish[1]]
    path = find_shortest_path(start, finish)
    if path
      puts "\nPath found: #{format_path(path)}"
      puts "Path length: #{path.length - 1}"
      path.each { |pos| @board.update_board(pos) }
    else
      puts 'No path found.'
    end
    @board.display
  end

  private

  def find_shortest_path(start, finish)
    start_pos = @move_validator.parse_position(start)
    finish_pos = @move_validator.parse_position(finish)

    queue = []
    visited = Array.new(8) { Array.new(8, false) }
    parent = {}

    queue << start_pos
    visited[start_pos[1]][start_pos[0]] = true

    until queue.empty?
      current = queue.shift
      return build_path(parent, start_pos, finish_pos) if current == finish_pos

      possible_moves(current).each do |next_move|
        x, y = next_move
        next if visited[y][x]

        queue << next_move
        visited[y][x] = true
        parent[position_id(next_move)] = current
      end
    end
    nil
  end

  def possible_moves(pos)
    x, y = pos
    KNIGHT_MOVES.map do |dx, dy|
      [x + dx, y + dy]
    end.select { |new_x, new_y| valid_position?(new_x, new_y) }
  end

  def valid_position?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end

  def build_path(parent, start_pos, finish_pos)
    path = [finish_pos]
    current_id = position_id(finish_pos)
    while path.last != start_pos
      current = parent[current_id]
      path << current
      current_id = position_id(current)
    end
    path.reverse.map { |pos| unparse_position(pos) }
  end

  def position_id(pos)
    x, y = pos
    y * 8 + x # Unique integer for each position
  end

  def format_path(path)
    path.map { |pos| "#{pos[0].upcase}#{pos[1]}" }.join(' -> ')
  end

  def unparse_position(pos)
    x, y = pos
    col = ('a'.ord + x).chr
    row = y + 1
    [col, row]
  end
end
