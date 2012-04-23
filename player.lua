Player = class:new()

function Player:init()
  self.texture = love.graphics.newImage('ear.png')
  self.gravity = 50

  self.body = Collider:addRectangle(50, 50, 32, 32)
  self.body.speed = 200.0
  self.body.type = 'player'
end

function Player:update(dt)
  self.body:move(0, self.gravity*dt)

  if love.keyboard.isDown('right') then
    self.body:move(self.body.speed * dt, 0)
  elseif love.keyboard.isDown('left') then
    self.body:move(-self.body.speed * dt, 0)
  elseif love.keyboard.isDown('up') then
    self.body:move(0, -self.body.speed * dt)
  elseif love.keyboard.isDown('down') then
    self.body:move(0, self.body.speed * dt)
  end
end

function Player:draw()
  love.graphics.draw(self.texture, self.body.x, self.body.y)
  self.body:draw('fill')
end
