require 'lib/Class'
require 'player'
require 'level'

local HC = require 'lib/HardonCollider'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
  player_with_tile(dt, shape_a, shape_b, mtv_x, mtv_y) 
end

function player_with_tile(dt, shape_a, shape_b, mtv_x, mtv_y)
  local player_shape, tile_shape
  print(shape_a.type)
  print(shape_b.type)
end

Collider = HC(100, on_collision)

level = Level:new()
local mode = 'debug'

function love.load()
  love.graphics.setBackgroundColor(0xaa, 0xbb, 0xaa)
end

function love.update(dt)
  level:update(dt)

  Collider:update(dt)
end

function love.draw()
  level:draw()
  
  if mode == 'debug' then
    love.graphics.print(love.timer.getFPS(), 10, 10)
  end
end

function love.keyreleased(key)
  if key == 'escape' then
    love.event.quit()
  end
end
