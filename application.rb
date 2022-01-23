# models a Tic Tac Toe game
class Game
  def initialize(player_1, player_2)
    @board = %w[
      a b c
      d e f
      g h i
    ]

    @players = [player_1, player_2]

    puts 'Player 1 goes first'
    self.play
  end

  def play
    turn = 0

    loop do
      display_board
      if turn.even?
        current_player = @players[0]
      else
        current_player = @players[1]
      end
      print "\n#{current_player.name}: "
      choice = gets.chomp
      if @board.include?(choice)
        @board[@board.index(choice)] = current_player.marker
      elsif choice == 'q'
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
end

class Player
  attr_reader :marker
  attr_reader :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

new_game = Game.new(Player.new('Player 1', 'X'), Player.new('Player 2', 'O'))