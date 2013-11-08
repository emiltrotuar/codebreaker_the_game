require_relative 'spec_helper'
require 'codebreaker'

module Codebreaker
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:input) { double('input').as_null_object }
    let(:game) { Game.new(input,output) }


    it "sends a welcome message and prompts for the first guess" do
      output.should_receive(:puts).with('Welcome to Codebreaker!')
      output.should_receive(:puts).with('Enter your guess or request a hint:')
      game.start
    end

    it "generates a secret code" do
      game.start
      sc = game.instance_variable_get(:@secret_code)
      sc.count.should eq 4
      sc.each { |i| i.class.should eq Fixnum }
    end

    it "gives a proper hint" do
      game.start
      sc = game.instance_variable_get(:@secret_code)
      sc.index(game.request_hint).should be_true
    end

    it "submits your guess" do
      input.stub(:gets).and_return("1234\n")
      game.submit
      game.instance_variable_get(:@guess).should eq [1,2,3,4]
    end

    it "allows you to win on the 3rd attempt" do
      game.should_receive(:generate_secret_code).and_return([1,2,3,4])
      input.stub(:gets).and_return("3245\n","4216\n","1234\n","Ben\n","n\n")
      output.should_receive(:puts).with('Congratulations! You win!')
      game.start
    end

    it "allows you to lose after 3 unsuccessful attempts" do
      game.should_receive(:generate_secret_code).and_return([1,2,3,4])
      input.stub(:gets).and_return("3245\n","4216\n","1652\n","n\n")
      output.should_receive(:puts).with('Unfortunately you lose!')
      game.start
    end

    it "allows you to play again" do
      input.stub(:gets).and_return("y\n")
      game.should_receive(:start)
      game.play_again
    end

    it "properly saves the last score" do
      input.stub(:gets).and_return("Ben\n")
      game.instance_variable_set(:@turns, 2)
      game.save_score
      sav_data = nil
      File.open 'score.txt', 'r' do |f|  
        sav_data = f.gets
      end
      sav_data.should eq "Ben: 10\n"
    end
  end
end