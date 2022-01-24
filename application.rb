# frozen_string_literal: true

# models a Tic Tac Toe game
class Game
  def initialize(player1, player2)
    @board = %w[
      a b c
      d e f
      g h i
    ]

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
      if board_full?(turn)
        puts 'Game over.'
        break
      end
      turn += 1
    end
  end

  protected

  def display_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts '----------'
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts '----------'
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  private

  def vaild_position?(choice)
    @board.include?(choice) ? true : false
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
    choice = gets.chomp
    if vaild_position?(choice)
      @board[@board.index(choice)] = player.marker
    else
      invalid_choice(player)
    end
  end

  def invalid_choice(player)
    puts 'Selection invalid.'
    display_board
    get_choice(player)
  end

  def board_full?(turn)
    true if turn >= 8
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
