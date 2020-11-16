class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def score
    @input = params[:input].upcase.split('')
    @url = "https://wagon-dictionary.herokuapp.com/#{params[:input]}"
    @user_serialized = open(@url).read
    @word = JSON.parse(@user_serialized)
    @letters = params[:letters]
    @score = params[:score].to_i
    if !@input.all? { |letter| @input.count(letter) <= @letters.count(letter) }
      @input = "This word can't be created out of #{@letters}"
    elsif !@word['found']
      @input = 'This is not an English word'
    else
      @input = 'Great you won!'
      cookies[:score] = params[:score].to_i + 1
    end
  end

  def new
    @letters = [*('A'..'Z')].sample(8)
  end
end
