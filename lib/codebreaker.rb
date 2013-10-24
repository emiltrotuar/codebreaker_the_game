require "codebreaker/version"

module Codebreaker
  class Game
    def initialize(input,output,player)
      @input = input
      @output = output
      @player = player
      @turns = 1
      generate_secret_code
    end
 
    def start
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
      @guess = @input.gets
      return unless @guess =~ /\d+/
      check
    end

    def submit
    	@guess = @input.gets.split //
      check
    end

    def generate_secret_code
      @secret_code=[]

    	4.times do
    		@secret_code << rand(6)
    	end
    	if @secret_code.uniq.count < 4
    		loop do
	    		@secret_code << rand(6)
	    		break if @secret_code.uniq.count == 4
    		end
    	end
    end

    def check
      @marks = []
    	4.times do |i|
	    	if @secret_code[i] == @guess[i]
	    		@marks << '+'
	    	elsif @guess.index @secret_code[i]
	    		@marks << '-'
	    	else 
          next
        end
    	end
    	@marks.count < 4
    	if !(@marks.index '-')
    		unless @marks.count < 4
    			you_win
    		else
    			@marks.clear
          @turns+=1
          submit
        end
      elsif @marks.index '-'
        p "#{@marks}"
        @turns+=1
    		@marks.clear
    		submit
    	else
    		you_lose
      end
    end

    def you_win
    	p 'congratulations! you win!'
    	p 'do you want to play again?'
      save_score
    end

    def you_lose
    	p 'unfortunately you lose!'
    	p 'do you want to try again?'
      save_score
    end


    def request_hint
      p "secret code contains #{@secret_code[rand 4]}"
    end

    def save_score
      File.open 'scores.txt', 'w' do |f|  
        f.puts "#{@player.name}: #{@turns}"    
      end
    end
  end
end