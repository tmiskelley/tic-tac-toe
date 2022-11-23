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

    context 'when the current player picks a non-empty spot' do
      before do
        test_board = [nil, nil, nil, nil, nil, 'X', nil, nil, nil, nil, nil]
        filled_spot = '5'
        empty_spot = '1'
        tictactoe.instance_variable_set(:@board, test_board)
        allow(tictactoe).to receive(:gets).and_return(filled_spot, empty_spot)
      end

      it 'returns an error message' do
        expect(tictactoe).to receive(:invalid_input).once
        tictactoe.send(:get_choice, player2)
      end
    end

    context 'when the current player enters a non-integer input' do
      before do
        letter = 'a'
        valid_entry = '5'
        allow(tictactoe).to receive(:gets).and_return(letter, valid_entry)
      end

      it 'returns an error message' do
        expect(tictactoe).to receive(:invalid_input).once
        tictactoe.send(:get_choice, player1)
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

  describe '#board_full?' do
    let(:player1) { double('player1') }
    let(:player2) { double('player2') }
    subject(:tictactoe) { described_class.new(player1, player2) }

    context 'when the board is full' do
      before do
        full_board = [nil, 'O', 'X', 'X', 'X', 'X', 'O', 'O', 'O', 'X']
        tictactoe.instance_variable_set(:@board, full_board)
      end

      it 'returns true' do
        expect(tictactoe.send(:board_full?)).to be(true)
      end
    end

    context 'when the board is NOT full' do
      before do
        full_board = [nil, 'O', nil, 'X', 'X', 'X', 'O', 'O', nil, 'X']
        tictactoe.instance_variable_set(:@board, full_board)
      end

      it 'returns false' do
        expect(tictactoe.send(:board_full?)).to be(false)
      end
    end
  end
end
