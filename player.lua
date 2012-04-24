Player = class:new()

local GRAVITY = 500
local JUMP_HEIGHT = 350

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
    self.body:move(self.body.speed * dt, 0)
  elseif love.keyboard.isDown('left') then
    self.body:move(-self.body.speed * dt, 0)
  elseif love.keyboard.isDown('up') then
    self.body:move(0, -self.body.speed * dt)
  elseif love.keyboard.isDown('down') then
    self.body:move(0, self.body.speed * dt)
  end

  if love.keyboard.isDown(' ') then
    -- we're not already in a jump, and we're not falling
    if not self.body.jumping and self.body.y_velocity >= 0 then
      self.body.y_velocity = JUMP_HEIGHT
      self.body.jumping = true
    end
  end

  if self.body.y_velocity ~= 0 then
    dy = -self.body.y_velocity * dt
    self.body.y_velocity = self.body.y_velocity - GRAVITY * dt
  else
    self.body.y_velocity = -GRAVITY * dt
  end

  self.body:move(dx, dy)

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
