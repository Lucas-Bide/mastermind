require_relative "board"
require_relative "computer_guesser"

class Mastermind
    
    def initialize
        choose_mode
    end

    def choose_mode
        print "Would you like to play guesser or code creator? (g/c) "
        answer = gets.chomp.downcase
        while answer != "g" && answer != 'c'
            print "\nEnter either 'g' or 'c'"
            answer = gets.chomp.downcase
        end
        answer == 'g' ? play_guesser : play_creator
    end

    def play_guesser
        puts "\nOn each turn, guess four colors, repeatable, from R,G,B,Y,P,O."
        puts "You get twelve guesses.\n"
        board = Board.new
        
        while !board.game_over?
            print "Guess: "
            guess = gets.chomp.upcase
            while !Board.valid_guess?(guess)
                print "\nPlease enter a valid guess. For example, RGGY: "
                guess = gets.chomp.upcase
            end
            board.guess(guess)
        end

        puts
        puts board.winner ? "You Won!" : "You Lost..."
        play_again
    end

    def play_creator
        print "Enter a four-digit code, repeatable, from R,G,B,Y,P,O: "
        code = gets.chomp.upcase
        while !Board.valid_guess?(code)
            print "\nPlease enter a valid code. For example, RGGY: "
            code = gets.chomp.upcase
        end
        board = Board.new(false, code)
        comp = ComputerGuesser.new

        puts "\nComputer: \"---All hail Donald Knuth, computational overlord----\""
        puts "\"Prepare to lose... in a minute. Genius takes time... right?\""
        pegs = board.guess(comp.first_guess())
        while !board.game_over?
            pegs = board.guess(comp.guess(pegs))
        end

        puts
        puts board.winner ? "The computer won!" : "You Lost..."

        play_again

    end

    def play_again
        print "Do you want to play again? (y/n) "
        answer = gets.chomp.downcase
        while answer != "y" && answer != 'n'
            print "\nEnter either 'y' or 'n': "
            answer = gets.chomp.downcase
        end
        
        choose_mode if answer == 'y'

        puts "Goodbye!"
    end
end

Mastermind.new