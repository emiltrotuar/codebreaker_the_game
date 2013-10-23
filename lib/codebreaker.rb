require "codebreaker/version"

module Codebreaker
  class Game
    def initialize(output)
      @output = output
    end
 
    def start
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
      @secret_code = []
      @guess = gets
      checker @guess
    end

    def submit
    	@guess = gets.split //
    end

    def codemaker
    	4.times do
    		@secret_code << rand(6)
    	end
    	if @secret_code.uniq.count == 4
    		break
    	else
    		loop do
	    		@secret_code << rand(6)
	    		break if @secret_code.uniq.count == 4
    		end
    	end
    end

    def checker
    	4.times do |i|
	    	if @secret_code[i] == @guess[i]
	    		@marks << '+'
	    	elsif @guess.index @secret_code[i]
	    		@marks << '-'
	    	else p ''
    	end
    	@marks.count < 4
    	unless @marks.index '-'
    		unless @marks.count < 4
    			you_win
    		else
    			@marks.clear
	    		guess
					checker
				end
    	elsif @marks.index '-'
    		p "#{@marks}"
    		@marks.clear
    		guess
    		checker
    	else 
    		you_lose
    end

    def you_win
    	p 'congratulations! you win!'
    	p 'do you want to play again?'
    end

    def you_lose
    	p 'unfortunately you lose!'
    	p 'do you want to try again?'
    end


    def request_hint

    end

    def save_score

    end
  end
end