class PlayersController < ApplicationController
  def list
    @players = fetch_players
  end

  def player
    @players = fetch_players
    @player = @players.find { |player| player.id == params[:id] }
  end

  def chart
  end

  def fetch_players
    sql_query = "SELECT * FROM players"
    @players = ActiveRecord::Base.connection.execute(sql_query)

    @players = @players.map do |hash|
      player = Player.new
      player.id = hash["id"]
      player.name = hash["name"].to_s
      player.team = hash["team"].to_s
      player.games = hash["games"].to_i
      player.category = hash["category"].to_s
      player.description = hash["description"].to_s
      player.year = hash["year"].to_i
      player.source = hash["source"].to_s
      player.repeat = hash["repeat"].to_s
      player
    end
    @players
  end
end
