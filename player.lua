Player = class:new()

local GRAVITY = 25
local JUMP_HEIGHT = 500

function Player:init()
  self.body = Collider:addRectangle(50, 50, 32, 32)
  Collider:setActive(self.body)
  self.body.speed = 200.0
  self.body.y_velocity = 0
  self.body.type = 'player'
  self.body.jumping = false
end

function Player:update(dt)
  local dx = 0
  local dy = 0

  if love.keyboard.isDown('right') then
    dx = self.body.speed
  elseif love.keyboard.isDown('left') then
    dx = -self.body.speed
  end

  if love.keyboard.isDown(' ') then
    -- we're not already in a jump, and we're not falling
    if not self.body.jumping and self.body.y_velocity >= 0 then
      self.body.y_velocity = JUMP_HEIGHT
      self.body.jumping = true
    end
  end

  if self.body.y_velocity ~= 0 then
    dy = -self.body.y_velocity
    self.body.y_velocity = self.body.y_velocity - GRAVITY
  else
    self.body.y_velocity = -GRAVITY
  end

  self.body:move(dx * dt, dy * dt)

  cam.x,cam.y=self.body:center()
  cam.x=math.floor(cam.x)
  cam.y=math.floor(cam.y)
end

function Player:keypressed(key)
  if key == ' ' then
  end
end

function Player:draw()
  self.body:draw('fill')
  love.graphics.print(self.body.y_velocity,0,100)
end
