# frozen_string_literal: true

module TicTacToe
  LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
    [3, 6, 9], [1, 5, 9], [3, 5, 7]
  ]
end

# models a Tic Tac Toe game
class Game
  include TicTacToe
  def initialize(player1, player2)
    @board = Array.new(10)

    @players = [player1, player2]

    puts 'Player 1 goes first'
    play
  end

  def play
    turn = 0
    loop do
      display_board
      current_player = select_player(turn)
      get_choice(current_player)
      if player_win?(current_player)
        display_board
        puts "#{current_player.name} wins!"
        return
      elsif board_full?
        display_board
        puts "\nGame tie."
        return
      end
      turn += 1
    end
  end

  protected

  def display_board
    col_separator, row_separator = " | ", "--+---+--"
    label_for_position = lambda{|position| @board[position] ? @board[position] : position}

    row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
    row_positions = [[1,2,3], [4,5,6], [7,8,9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts rows_for_display.join("\n" + row_separator + "\n")
  end

  private

  def free_positions
    (1..9).select { |position| @board[position].nil? }
  end

  def select_player(turn)
    if turn.even?
      @players[0]
    else
      @players[1]
    end
  end

  def get_choice(player)
    print "\n#{player.name}: "
    begin
      choice = Integer(gets.chomp)
    rescue ArgumentError
      puts 'Please enter a valid number'
      get_choice(player)
    else
      @board[choice] = player.marker
    end
  end

  def player_win?(player)
    LINES.any? do |line|
      line.all? { |position| @board[position] == player.marker }
    end
  end

  def board_full?
    free_positions.empty?
  end
end

# Models player attributes for Tic Tac Toe game
class Player
  attr_reader :marker, :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

Game.new(Player.new('Player 1', 'X'), Player.new('Player 2', 'O'))
