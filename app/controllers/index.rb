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

post '/games/:id' do
  @winner = Player.find_by(name: params[:winner])
  @game = Game.find(params[:id])
  @game.winner = @winner
  @game.save
  content_type :json
  { url: @game.url }.to_json
end

get '/:custom_url' do
  @game = Game.find_by(url: params[:custom_url])
  puts @duration = @game.updated_at - @game.created_at
  slim :'games/results'
end
