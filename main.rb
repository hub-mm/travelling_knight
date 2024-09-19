# main.rb
# frozen_string_literal: true

require_relative 'lib/travel'

test = Travel.new
test.knight_moves(['A', 1], ['h', 8])
# test.knight_moves(['C', 5])
# test.knight_moves(['e', 6])
# test.knight_moves(['d', 8], ['b', 7])
