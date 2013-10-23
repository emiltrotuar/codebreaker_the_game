require_relative 'spec_helper'
require 'codebreaker'
  
module Codebreaker
  describe Game do
    describe "#start" do
      let(:output) { double('output').as_null_object }
      let(:game)   { Game.new(output) }
 
      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.start
      end
 
      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.start
      end

      it "wins" do

      end

      it "submits guess" do

      end

      it "loses" do

      end

      it "requests hint" do

      end

      it "saves score" do

      end
    end
  end
end