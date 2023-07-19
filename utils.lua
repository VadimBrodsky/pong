function displayFPS(font)
	love.graphics.setFont(font)
	love.graphics.setColor(0 / 255, 255 / 255, 0 / 255, 255 / 255)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 0, 0)
end
function displayTitle(state)
  love.graphics.setFont(smallFont)
  if state == 'start' then
    love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
  elseif state == 'serve' then
    love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 
      0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
  elseif state == 'play' then
    -- no UI messages to display in play
  end
end
