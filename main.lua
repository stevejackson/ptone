require 'lib/Class'
require 'player'
require 'level'

Camera = require 'lib/hump/camera'

local HC = require 'lib/HardonCollider'
local num_player_tile_collisions = 0

function on_collision(dt, a, b, dx, dy)
  player_with_tile(dt, a, b, dx, dy) 
end

function player_with_tile(dt, a, b, dx, dy)
  local player_shape, tile_shape

  if a.type == 'player' and b.type == 'tile' then
    player_shape,tile_shape = a,b

    if math.abs(dy) > math.abs(dx) then
			if dy < 0 then
				player_shape.y_velocity = 0
        player_shape.jumping = false
        num_player_tile_collisions = num_player_tile_collisions + 1
			else
				player_shape.y_velocity = 0
			end
    end
  elseif a.type == 'tile' and b.type == 'player' then
    player_shape,tile_shape = b,a

    dx, dy = -dx, -dy

    if math.abs(dy) > math.abs(dx) then
			if dy < 0 then
				player_shape.y_velocity = 0
        player_shape.jumping = false
        num_player_tile_collisions = num_player_tile_collisions + 1
			else
				player_shape.y_velocity = 0
			end
    end
  else
    return nil
  end

  -- if the player is standing on two blocks at once, don't correct for both
  if num_player_tile_collisions < 2 then
    player_shape:move(dx, dy)
    cam.x,cam.y=player_shape:center()
    cam.x=math.floor(cam.x)
    cam.y=math.floor(cam.y)
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
  num_player_tile_collisions = 0 -- reset every frame
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
