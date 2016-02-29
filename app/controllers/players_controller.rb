class PlayersController < ApplicationController
  def list
    @players = fetch_players
    @players = Kaminari.paginate_array(@players).page(params[:page]).per(15)
  end

  def player
    @players = fetch_players
    @player = @players.find { |player| player.id == params[:id] }
  end

  def chart
    @players = fetch_players
    @suspensions_by_team = Hash.new(0)
    @suspensions_by_category = Hash.new(0)
    @players.each { |player| @suspensions_by_team[player.team] += 1 }
    @players.each { |player| @suspensions_by_category[player.category] += 1 }
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
