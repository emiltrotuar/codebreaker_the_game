# require "codebreaker/version"

module Codebreaker
  class Game
    def initialize(input=$stdin, output=$stdout)
      @input = input
      @output = output
    end

    def start
      @turns = 0
      @secret_code = generate_secret_code
      # p @secret_code
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter your guess or request a hint:'
      submit
      result = case check
      when 'won'
        you_won
      when 'lose'
        you_lose
      end
    end

    def submit
      g = @input.gets.chop
      @guess = case g
      when 'r'
        request_hint
        submit
      else
        g.split(//).select do |i|
          /\d+/.match i
        end.map!(&:to_i)[0..3]
      end
    end

    def generate_secret_code
      sc = []
      loop do
       sc << rand(1..6)
        sc.uniq!
        return sc if sc.count == 4
      end
    end

    def check
      @marks = []
      4.times do |i|
        if @secret_code[i] == @guess[i]
          @marks << '+'
        elsif @secret_code.index @guess[i]
          @marks << '-'
        else 
          @marks << 'N'
        end
      end
      if !(@marks.index '-') && !(@marks.index 'N')
        @guess=[]
        'won'
      elsif (@marks.index '-') || (@marks.index 'N')
        next_attempt_or_defeat
      else
        @guess=[]
        'lose'
      end
    end

    def next_attempt_or_defeat
      @marks.each { |m| print m  }; @output.puts
      @guess=[]
      @turns+=1
      return 'lose' if @turns >= 3
      @output.puts "#{3-@turns} attempts left"
      @marks.clear
      submit
      check
    end

    def you_won
      @output.puts 'Congratulations! You win!'
      save_score
      @output.puts 'Do you want to play again?'
      play_again
    end

    def you_lose
      @output.puts 'Unfortunately you lose!'
      @output.puts 'Do you want to try again? [yn]'
      play_again
    end

    def play_again
      dec = @input.gets.chop
      return unless dec == 'y'
      start
    end

    def request_hint
      rnd = @secret_code[rand 4]
      @output.puts "secret code contains #{rnd}"
      rnd
    end

    def save_score
      @output.puts 'Please enter your name, we want to save your score:'
      your_name = @input.gets.chop
      File.open 'score.txt', 'w' do |f|  
        f.puts "#{your_name}: #{30-@turns*10}"  
      end
    end
  end
end