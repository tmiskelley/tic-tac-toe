# frozen_string_literal: true

require './lib/tic_tac_toe'

TicTacToe.new(Player.new('Player 1', 'X'), Player.new('Player 2', 'O')).play
