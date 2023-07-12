function displayFPS(font)
	love.graphics.setFont(font)
	love.graphics.setColor(0 / 255, 255 / 255, 0 / 255, 255 / 255)
	love.graphics.print('FPS ' .. tostring(love.timer.getFPS()), 0, 0)
end
