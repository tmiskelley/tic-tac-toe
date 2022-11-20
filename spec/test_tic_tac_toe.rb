# frozen_string_literal: true

require './lib/tic_tac_toe'

describe TicTacToe do
  describe '#select_player' do
    let(:player1) { double('player1') }
    let(:player2) { double('player2') }
    subject(:tictactoe) { described_class.new(player1, player2) }

    context 'when current player is player 1' do
      before do
        players = tictactoe.instance_variable_get(:@players)
        tictactoe.instance_variable_set(:@current_player, players[0])
      end

      it 'switches to player 2' do
        current_player = tictactoe.send(:select_player)
        expect(current_player).to eq(player2)
      end
    end

    context 'when current player is player 2' do
      it 'switches to player 1' do
        current_player = tictactoe.send(:select_player)
        expect(current_player).to eq(player1)
      end
    end
  end

  describe '#get_choice' do
    let(:player1) { double(name: 'player1', marker: 'X') }
    let(:player2) { double(name: 'player2', marker: 'O') }
    subject(:tictactoe) { described_class.new(player1, player2) }

    context 'when player 1 picks an empty spot' do
      before do
        allow(tictactoe).to receive(:gets).and_return('5')
      end

      it "updates spot to player 1's marker" do
        tictactoe.send(:get_choice, player1)
        spots = tictactoe.instance_variable_get(:@board)
        expect(spots[5]).to eq('X')
      end
    end

    context 'when player 2 picks an empty spot' do
      before do
        allow(tictactoe).to receive(:gets).and_return('1')
      end

      it "updates spot to player 2's marker" do
        tictactoe.send(:get_choice, player1)
        spots = tictactoe.instance_variable_get(:@board)
        expect(spots[1]).to eq('X')
      end
    end
  end

  describe '#player_win?' do
    let(:player1) { double('player1', marker: 'X') }
    let(:player2) { double('player2') }
    subject(:tictactoe) { described_class.new(player1, player2) }

    context 'when the current lines do not match a win condition' do
      it 'returns false' do
        result = tictactoe.send(:player_win?, player1)
        expect(result).to be(false)
      end
    end

    context 'When the current lines match a win condition' do
      before do
        win_array = [nil, 'X', 'O', 'O', nil, 'X', nil, 'O', nil, 'X', nil]
        tictactoe.instance_variable_set(:@board, win_array)
      end

      it 'returns true' do
        result = tictactoe.send(:player_win?, player1)
        expect(result).to be(true)
      end
    end
  end
end
