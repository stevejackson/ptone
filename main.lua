require 'lib/Class'
require 'player'
require 'level'

Camera = require 'lib/hump/camera'

local HC = require 'lib/HardonCollider'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
  player_with_tile(dt, shape_a, shape_b, mtv_x, mtv_y) 
end

function player_with_tile(dt, shape_a, shape_b, mtv_x, mtv_y)
  local player_shape, tile_shape

  if shape_a.type == 'player' and shape_b.type == 'tile' then
    player_shape = shape_a
    tile_shape = shape_b

    player_shape:move(mtv_x, mtv_y)
    if math.abs(mtv_y) > math.abs(mtv_x) then
			if mtv_y < 0 then
				player_shape.y_velocity = 0
        player_shape.jumping = false
			else
				player_shape.y_velocity = -1
			end
    end
  elseif shape_a.type == 'tile' and shape_b.type == 'player' then
    player_shape = shape_b
    tile_shape = shape_a

    player_shape.move(mtv_x, mtv_y)
    if math.abs(mtv_y) > math.abs(mtv_x) then
			if mtv_y < 0 then
				player_shape.y_velocity = 0
        player_shape.jumping = false
			else
				player_shape.y_velocity = -1
			end
    end
  else
    return nil
  end
end

Collider = HC(100, on_collision)

level = Level:new()
local mode = 'debug'
cam = Camera(400,400,1,0)

function love.load()
  love.graphics.setBackgroundColor(0xaa, 0xbb, 0xaa)
end

function love.keypressed(key)
  level:keypressed(key)
end

function love.update(dt)
  -- update order:
  --  player update (gravity, movement)
  --  level update
  --  collision update
  level:update(dt)
  Collider:update(dt)
end

function love.draw()
  cam:attach()
  level:draw()
  cam:detach()
  
  if mode == 'debug' then
    love.graphics.print(love.timer.getFPS(), 10, 10)
  end
end

function love.keyreleased(key)
  if key == 'escape' then
    love.event.quit()
  end
end
