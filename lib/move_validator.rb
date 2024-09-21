# frozen_string_literal: true

class MoveValidator
  def valid_knight_move?(start, finish)
    start_pos = parse_position(start)
    finish_pos = parse_position(finish)
    move_diff = calculate_move_difference(start_pos, finish_pos)

    (move_diff[0].abs == 2 && move_diff[1].abs == 1) || (move_diff[0].abs == 1 && move_diff[1].abs == 2)
  end

  def parse_position(array)
    x = letter_to_number(array[0])
    y = array[1] - 1 # Convert chess row to array index (0-based)
    [x, y]
  end

  private

  def calculate_move_difference(start_pos, finish_pos)
    [start_pos[0] - finish_pos[0], start_pos[1] - finish_pos[1]]
  end

  def letter_to_number(letter)
    letter.downcase.ord - 'a'.ord
  end
end
