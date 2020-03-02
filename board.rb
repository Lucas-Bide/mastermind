class Board
    attr_reader :winner, :board
    @@COLORS = ["R", "G", "B", "Y", "P", "O"]
    
    def initialize human_guesser=true, human_made_code=""
        @board = []
        if human_guesser
            @code = ""
            4.times {|t| @code += @@COLORS.sample}
            @code = @code.split("")
        else
            @code = human_made_code
        end
        @winner
    end

    def game_over?
        !@winner.nil?
    end

    # Pre-condition: 'row' is in the correct format
    def guess row
        @board.push(row)
        
        pegs = Board.silent_guess(row, @code)
        black_pegs = pegs[0]
        white_pegs = pegs[1]

        if black_pegs == 4
            @winner = true
        elsif @board.length == 12
            @winner = false
        end
        
        puts "\nExact: #{black_pegs} Color: #{white_pegs}"
        #puts "Debugging tool: Answer: #{@code}"

        pegs
    end

    def self.silent_guess row, code
        guesses = row.split("")
        black_pegs = 0
        white_pegs = 0
        remaining_colors = []
        
        guesses.each_with_index {|guess, index| guess == code[index] ? (black_pegs += 1) && guesses[index] = "correct" : remaining_colors.push(code[index])}
        guesses.each { |guess| (white_pegs += 1) && remaining_colors.delete(guess) if remaining_colors.include?(guess)}

        [black_pegs, white_pegs]
    end

    def self.valid_guess? guess
        guess.length == 4 && guess.split("").uniq - @@COLORS == []
    end
end