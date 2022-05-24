require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split("")
    if word_in_letters(@word, @letters)
      valid_word?
    else
      @message = "sorry, #{@word} includes letters that aren't in the grid."
    end
  end

  def word_in_letters(word, letters)
    word.chars.all? do |word_letter|
      letters.include?(word_letter)
    end
  end

  def valid_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    word = JSON.parse(user_serialized)

    if word["found"] == true
      @message = "Congrats, #{@word} is a valid English word!"
    else
      @message = "Sorry, #{@word} is not a valid English word."
    end
  end
end
