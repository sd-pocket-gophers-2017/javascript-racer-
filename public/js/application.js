function Player(number, name) {
  this.id = 'player' + number
  this.name = name
  this.currentIndex = 1
}

Player.prototype.$row = function() {
  return $('#' + this.id)
}

Player.prototype.$currentPosition = function() {
  return this.$row().find('.active')
}

Player.prototype.$newPosition = function() {
  return $(this.$row().find('td')[this.currentIndex + 1])
}

Player.prototype.updatePlayerPosition = function() {
  this.$currentPosition().removeClass('active')
  this.$newPosition().addClass('active')
  this.currentIndex += 1
}

function Game() {
  this.$row1 = $('#player1')
  this.$row2 = $('#player2')
}

Game.prototype.resetBoard = function(player1, player2) {
  player1.currentIndex = 1
  player2.currentIndex = 1
  this.$row1.find('td.active').removeClass('active')
  this.$row2.find('td.active').removeClass('active')
  $(this.$row1.find('td')[1]).addClass('active')
  $(this.$row2.find('td')[1]).addClass('active')
  $('h1').text('')
}

Game.prototype.play = function(player1, player2) {
  $(document).on('keyup', function(event) {
    var code = event.which
    if (code === 81) {
      player1.updatePlayerPosition()
      this.gameOver(player1, player2)
    } else if (code === 80) {
      player2.updatePlayerPosition()
      this.gameOver(player1, player2)
    }
  }.bind(this))
}

Game.prototype.gameOver = function(player1, player2) {
  if (player1.currentIndex > 6 || player2.currentIndex > 6) {
    $(document).off('keyup')
    if (player1.currentIndex > 6) {
      $('h1').text(player1.name + ' wins!!!!')
    } else {
      $('h1').text(player2.name + ' wins!!!!')
    }
    $(document).on('keyup', function(event) {
      var code = event.which
      if (code === 13) {
        $(document).off('keyup')
        this.resetBoard(player1, player2)
        this.play(player1, player2)
      }
    }.bind(this))
  }
}

$(document).ready(function() {
  var game = new Game()
  var firstPlayer = new Player('1', $(game.$row1.find('td')[0]).text())
  var secondPlayer = new Player('2', $(game.$row2.find('td')[0]).text())
  game.resetBoard(firstPlayer, secondPlayer)
  game.play(firstPlayer, secondPlayer)
})
