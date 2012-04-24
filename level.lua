local loader = require 'lib/AdvTiledLoader/Loader'
loader.path = 'data/maps/'

Level = class:new()

function Level:init()
  self.map = loader.load('desert.tmx')
  self.allSolidTiles = findSolidTiles(self.map)
  self.scale = 1

  self.player = Player:new()
end

function Level:keypressed(key)
  self.player:keypressed(key)
end

function Level:update(dt)
  self.player:update(dt)
end

function Level:draw()
  self.map:setDrawRange(-math.huge, -math.huge, math.huge, math.huge)
  self.map:draw()
  self.player:draw()
end

function findSolidTiles(map)
  local collidable_tiles = {}

  local layer = map.tl["ground"]

  for tileX=1,map.width-1 do
    for tileY=1,map.height-1 do
      local tile = layer.tileData(tileX, tileY)

      if tile and tile.properties.solid then
        local ctile = Collider:addRectangle(tileX * 32, tileY * 32, 32, 32)
        ctile.type = "tile"
        Collider:addToGroup("tiles", ctile)
        Collider:setPassive(ctile)
        table.insert(collidable_tiles, ctile)
      end

    end
  end

  return collidable_tiles
end
