push = require 'vendor.push.push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  smallFont = love.graphics.newFont('assets/font.ttf', 8)
  scoreFont = love.graphics.newFont('assets/font.ttf', 32)

  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())

  push:setupScreen(
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

  player1Y = 30
  player2Y = VIRTUAL_HEIGHT - 50

  ballX = VIRTUAL_WIDTH / 2 - 2
  ballY = VIRTUAL_HEIGHT / 2 - 2
end

function love.draw()
  push:apply('start')

  love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

  -- title
  love.graphics.setFont(smallFont)
  love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

  -- scores
  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

  -- left paddle
  love.graphics.rectangle('fill', 10, player1Y, 5, 20)

  -- right paddle
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

  -- ball
  love.graphics.rectangle('fill', ballX, ballY, 4, 4)

  push:apply('end')
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
    player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
  end

  if love.keyboard.isDown('up') then
    player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
    player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
  end
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end
