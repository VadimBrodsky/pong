Push = require 'vendor.push.push'
Class = require 'vendor.hump.class'

require 'Paddle'
require 'Ball'
require 'utils'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 426
VIRTUAL_HEIGHT = 240

PADDLE_SPEED = 200

function love.load()
  smallFont = love.graphics.newFont('assets/font.ttf', 8)
  scoreFont = love.graphics.newFont('assets/font.ttf', 32)

  love.graphics.setDefaultFilter('nearest', 'nearest')
  smallFont:setFilter('nearest', 'nearest')
  scoreFont:setFilter('nearest', 'nearest')

  love.window.setTitle('Pong')
  math.randomseed(os.time())

  Push:setupScreen(
    VIRTUAL_WIDTH,
    VIRTUAL_HEIGHT,
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    {
      fullscreen = false,
      resizable = false,
      vsync = true
    }
  )

  player1Score = 0
  player2Score = 0
  servingPlayer = 1

  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  gameState = 'start'
end

function love.draw()
  Push:apply('start')

  love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

  -- title
  displayTitle(gameState)

  -- scores
  displayScore()

  player1:render()
  player2:render()
  ball:render()

  displayFPS(smallFont)

  Push:apply('end')
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    player1.dy = PADDLE_SPEED
  else
    player1.dy = 0
  end

  if love.keyboard.isDown('i') then
    player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('k') then
    player2.dy = PADDLE_SPEED
  else
    player2.dy = 0
  end

  if gameState == 'serve' then
    ball.dy = math.random(-50, 50)
    if servingPlayer == 1 then
      ball.dx = math.random(140, 200)
    else
      ball.dx = -math.random(140, 200)
    end
  elseif gameState == 'play' then
    if ball:collides(player1) then
      ball.dx = -ball.dx * 1.03
      ball.x = player1.x + 5

      -- keep velocity going in the same direction but randomize the angle
      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
    end

    if ball:collides(player2) then
      ball.dx = -ball.dx * 1.03
      ball.x = player2.x - 4

      -- keep velocity going in the same direction but randomize the angle
      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
    end

    -- detect upper and lower screen boundary collision and reverse it
    if ball.y <= 0 then
      ball.y = 0
      ball.dy = -ball.dy
    end

    -- -4 to account for ball's height
    if ball.y >= VIRTUAL_HEIGHT - 4 then
      ball.y = VIRTUAL_HEIGHT - 4
      ball.dy = -ball.dy
    end

    -- detect collision with the left side of the screen
    if ball.x < 0 then
      servingPlayer = 1
      player2Score = player2Score + 1
      ball:reset()
      gameState = 'serve'
    end

    if ball.x > VIRTUAL_WIDTH then
      servingPlayer = 2
      player1Score = player1Score + 1
      ball:reset()
      gameState = 'serve'
    end

    ball:update(dt)
  end

  player1:update(dt)
  player2:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'serve'
    elseif gameState == 'serve' then
      gameState = 'play'
    else
      gameState = 'start'
      ball:reset()
    end
  end
end
