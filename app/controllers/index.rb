get '/' do
  slim :'/index'
end

get '/games/new' do
  slim :'games/new'
end

post '/games' do
  game = Game.new()
  player1 = Player.find_or_create_by(name: params[:game][:player1])
  player2 = Player.find_or_create_by(name: params[:game][:player2])
  game.players += [player1, player2]
  game.save
  redirect :"games/#{game.id}"
end

get '/games/:id' do
  @game = Game.find(params[:id])
  @player1 = @game.players[0]
  @player2 = @game.players[1]
  slim :'/games/show'
end
