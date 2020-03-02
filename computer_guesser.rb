class ComputerGuesser
    #[b,w]
    @@peg_combos = [[1,0],[0,1],[1,1],[2,0],[0,2],[3,0],[0,3],[2,1],[1,2],[4,0],[0,4],[2,2],[3,1],[1,3]]
    
    def initialize
        @guess_set = ["B","G","O","P","R","Y"].repeated_permutation(4).to_a.map {|guess| guess.join}
        @unused_codes = @guess_set
        @guess = "BBGG"
    end

    def first_guess
        @guess_set.delete(@guess)
        @unused_codes.delete(@guess)
        puts "\n#{@guess}"
        @guess
    end

    #Pre-condition: #first_guess must be called first.
    def guess (pegs)
        pool = @guess_set.select {|code| Board.silent_guess(@guess, code) == pegs}
        puts "pool size " + pool.size.to_s
        @guess_set = pool
        
        #i = 0
        maximin = {}
        @unused_codes.each do |code| 
            min_score = min_score(code)
        #    puts "Score #{i += 1} calculated: #{code}: #{min_score}"
            maximin[min_score].nil? ? maximin[min_score] = [code] : maximin[min_score].push(code)
        end

        max_mins = maximin[maximin.keys.max]
        max_mins.select! {|code| @guess_set.include?(code)} if max_mins.any? {|code| @guess_set.include?(code)}
        @guess = max_mins.min
       
        @guess_set.delete(@guess)
        @unused_codes.delete(@guess)
        puts @guess
        @guess
    end

    private
    
    def min_score (code)
        scores = []
        @@peg_combos.each do |peg_combo|
            score = 0
            @guess_set.each {|sol| (score += 1) if (Board.silent_guess(code, sol) == peg_combo)}
            scores.push(score)#@guess_set.size - score            
        end
        #puts scores.to_s
        scores.max
    end
end
