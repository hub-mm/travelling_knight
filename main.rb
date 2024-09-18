# main.rb
# frozen_string_literal: true

require_relative 'lib/board'

test = Board.new
test.change_board('a', 1)
test.change_board('D', 5)
test.change_board('P', 3)
