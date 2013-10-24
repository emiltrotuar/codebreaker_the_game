require_relative 'spec_helper'
require 'codebreaker'
  
module Codebreaker
  describe Game do
    describe "#start" do
      let(:output) { double('output').as_null_object }
      let(:input) { double('input').as_null_object }
      let(:player) { double('player').as_null_object }
      let(:game)   { Game.new(input,output,player) }
      
      it "generates a secret code" do
        game.generate_secret_code
      end
 
      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.start
      end
 
      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.start
      end

      it "submits guess" do
        input.should_receive(:gets).and_return('1234')
        game.submit
      end

      it "compares guess with a secret code" do
        input.should_receive(:gets).and_return('1234')
        game.submit
        game.check
      end

      it "allows you to win" do
        player.should_receive(:name).and_return('John')
        game.you_win
      end

      it "allows you to lose" do
        game.you_lose
      end

      it "requests hint" do
        game.generate_secret_code
        game.request_hint
      end

      it "saves score" do
        player.should_receive(:name).and_return('John')
        game.save_score
      end
    end
  end
end