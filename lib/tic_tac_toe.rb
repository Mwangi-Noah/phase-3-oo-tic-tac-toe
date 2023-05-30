class TicTacToe
      
    def initialize
      @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
        [0, 4, 8], [6, 4, 2]            # Diagonals
      ].freeze
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
  
    def input_to_index(input)
      input.to_i - 1
    end
  
    def move(index, token = "X")
        @board[index] = token        
    end
  
    def position_taken?(index)
        (@board[index] == "X" || @board[index] == "O")
    end
  
    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end
  
    def turn_count
        @board.count { |token| token == "X" || token == "O" }
    end
  
    def current_player
      turn_count.even? ? "X" : "O"
    end
  
    def turn
        puts "Please enter a number between 1 and 9:"
        input = gets.strip
      
        index = input_to_index(input)
        player = current_player
      
        if valid_move?(index)
          move(index, player)
          display_board
        else
          puts "Invalid move. Please try again."
          turn
        end
    end
  
    def won?
        WIN_COMBINATIONS.each do |combination|
          index_1 = combination[0]
          index_2 = combination[1]
          index_3 = combination[2]
      
          position_1 = @board[index_1]
          position_2 = @board[index_2]
          position_3 = @board[index_3]
      
          if position_1 == position_2 && position_2 == position_3 && position_1 != " "
            return combination
          end
        end
      
        return false
    end
  
    def full?
        @board.all? { |position| position == "X" || position == "O" }
    end
  
    def draw?
      !won? && full?
    end
  
    def over?
      won? || draw?
    end
  
    def winner
        if win_combination = won?
          @board[win_combination[0]]
        end
    end
  
    def play
        while !over?
          turn
        end
      
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
    end
  end