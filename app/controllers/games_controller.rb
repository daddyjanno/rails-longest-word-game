require 'open-uri'
require 'json'

class GamesController < ApplicationController
  before_action :generate_letters

  def new
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']
  end

  def include?(word)
    # définir une méthode pour vérifier que chaque lettre composant @word est incluse dans @letters

    word.chars.include?(@letters)
  end

  def score
    raise
    @word = (params[:word]).upcase

    if english_word?(@word) == false
      @score = "Sorry, '#{@word}' is not in the dictionnary"
    elsif include?(@word) == false
      @score = "Sorry, the letters '#{@word}' are not in the grid"
    else
      @score = 'congrats!'
    end
  end

  private

  def generate_letters
    @letters = ('A'..'Z').to_a.sample(10)
  end
end
