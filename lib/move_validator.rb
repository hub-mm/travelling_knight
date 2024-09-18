# move_validator.rb
# frozen_string_literal: true

class MoveValidator
  def valid_knight_move?(start, finish)
    start_pos = parse_postition(start)
    finish_pos = parse_postition(finish)
    move_diff = calculate_move_difference(start_pos, finish_pos)

    (move_diff[0].abs == 2 && move_diff[1].abs == 1) || (move_diff[0].abs == 1 && move_diff[1].abs == 2)
  end

  def parse_postition(cell)
    [letter_to_number(cell[0]), cell[1]]
  end

  private

  def calculate_move_difference(start_pos, finish_pos)
    [start_pos[0] - finish_pos[0], start_pos[1] - finish_pos[1]]
  end

  def letter_to_number(cell_two)
    small_cell_two = cell_two.downcase.to_sym

    change = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    change[small_cell_two]
  end
end
