tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)

--game variables

local players = {}
local healthPacks = {}

--creating the class Player

local Player = {}
Player.__index = Player
Player.__tostring = function(self)
    return "[name=" .. self.name .. ",money=" .. self.money .. ", health=" .. self.health .. "]"
end

setmetatable(Player, {
  __call = function (cls, name)
    return cls.new(name)
  end,
})

function Player.new(name)
    local self = setmetatable({}, Player)
	   self.name = name
    self.money = 0
    self.health = 1.0
	  return self
end

function Player:getName() return self.name end
function Player:getMoney() return self.money end
function Player:getHealth() return self.health end

function Player:work()
    self.money = self.money + 10
end

function Player:setHealth(val, add)
	if add then
		self.health = self.health + 10
	else 
		self.health = val
	end
end

function Player:useMed(med)
	if not self.health >= 1  then 	
		self:setHealth(med:regainValue(), med:isAdding())
	end
		
end


--class creation(Player) ends

--creating class HealthPacks

local HealthPacks = {}
HealthPacks.__index = HealthPacks
HealthPacks.__tostring = function(self) 
	return "[name=" .. self.name .. ", price=" .. self.price .. ", regain=" .. self.regainVal .. ", add=" .. tostring(self.add) .. "]" 
end
HealthPacks.__type = "HealthPacks"

setmetatable(HealthPacks, {
  __call = function (cls, name, price, regain, add)
    return cls.new(name, price, regain, add)
  end,
})

function HealthPacks.new(name, price, regainVal, add)
	local self = setmetatable({}, HealthPacks)
	self.name = name
	self.price = price
	self.regainVal = regainVal
	self.add = add
	return self
end


function HealthPacks:getName() return self.name end
function HealthPacks:getPrice() return self.price end
function HealthPacks:getRegain() return self.regainVal end
function HealthPacks:isAdding() return self.add end

--event handling

function eventNewPlayer(name)
    players[name] = Player(name)
end

function eventPlayerLeft(name)
    for n, player in ipairs(players) do
        if player:getName() == name then
                table.remove(players, n)
        end
    end    
end

--function for the money clicker c:
function eventTextAreaCallback(id, name, evt)
 	if evt == "work" then
 		players[name]:work()	
		ui.updateTextArea(1, "Money : $" .. players[name]:getMoney(), name)
	elseif evt == "shop" then
		ui.addTextArea(100, "The Shop - CLOSED!!!", name, 200, 50, 400, 200, nil, nil, 1, true)
		for id, pack in ipairs(healthPacks) do print(tostring(pack)) end
	end
end


--event handling ends

--game logic

table.insert(healthPacks, HealthPacks("Burger", 10, 0.1, false))
print("type" .. type(HealthPacks("", 32, 5)))

for name, player in pairs(tfm.get.room.playerList) do
    players[name] = Player(name)
end

print('now printing myself')
for name, player in pairs(players) do
    print(name .. ':' .. tostring(player))
end

--textAreas
--work button
ui.addTextArea(0, "<a href='event:work'>Work!", nil, 7, 375, 36, 20, 0x324650, 0x000000, 1, true)
--stats
ui.addTextArea(1, "Money : $0", name, 6, 26, 150, 20, 0x324650, 0x000000, 1, true)
--shop buttons
medicTxt = ""
for id, medic in ipairs(healthPacks) do
	--TODO: SET MEDICAL TEXT TO BE DISPLAYED IN THE SHOP
	--medicTxt = medicTxt .. medic:getName() .. "Power: " .. medic:
end
ui.addTextArea(2, "<a href='event:shop'>Shop</a>", nil, 740, 375, 36, 20, nil, nil, 1, true)


