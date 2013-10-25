require_relative 'spec_helper'
require 'codebreaker'

module Codebreaker
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:input) { double('input').as_null_object }
    let(:game) { Game.new(input,output) }


    it "sends a welcome message" do
      output.should_receive(:puts).with('Welcome to Codebreaker!')
      game.start
    end

    it "prompts for the first guess" do
      output.should_receive(:puts).with('Enter your guess or request a hint:')
      game.start
    end

    it "generates a secret code" do
      game.generate_secret_code
      sc = game.instance_variable_get(:@secret_code)
      sc.count.should eq 4
      sc.each { |i| i.class.should eq Fixnum }
    end

    it "submits you guess" do
      input.stub(:gets).and_return("1234\n")
      game.submit
      game.instance_variable_get(:@guess).should eq [1,2,3,4]
      game.instance_variable_get(:@guess).count.should eq 4
    end

    it "compares guess with a secret code and return won" do
      input.stub(:gets).and_return("1234\n")
      game.submit
      game.instance_variable_set(:@secret_code, [1,2,3,4])
      game.check.should eq 'won'
    end

    it "allows you to win" do
      output.should_receive(:puts).with('Congratulations! You win!')
      game.you_won
    end

    it "allows you to lose" do
      output.should_receive(:puts).with('Unfortunately you lose!')
      game.you_lose
    end

    it "requests hint" do
      sc = game.instance_variable_set(:@secret_code, [1,2,3,4])
      sc.index(game.request_hint).should be_true
    end

    it "saves score" do
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