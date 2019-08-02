tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)

--game variables


local CONSTANTS = {
    BAR_WIDTH = 735,
    BAR_X = 60,
    STAT_BAR_Y = 30,

}

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
    self.healthBarId = 1000 + #players
    self.xpBarId = 2000 + #players
    self.healthRate = 0.002
    self.xp = 0
    self.level = 1
    ui.addTextArea(self.healthBarId, "", name, CONSTANTS.BAR_X, 340, CONSTANTS.BAR_WIDTH, 20, 0xff0000, 0xee0000, 1, true)
    ui.addTextArea(self.xpBarId, "", name, CONSTANTS.BAR_X, 370, 1, 17, 0x00ff00, 0x00ee00, 1, true)
    return self
end

function Player:getName() return self.name end
function Player:getMoney() return self.money end
function Player:getHealth() return self.health end
function Player:getHealthBarId() return self.healthBarId end
function Player:getHealthRate() return self.healthRate end
function Player:getXP() return self.xp end
function Player:getLevel() return self.level end

function Player:work()
    if self.health -0.05 > 0 then
        self.setHealth(self, -0.05, true)
        self:setMoney(10, true)
        self:setXP(1, true)
        self:levelUp()
    end
end

function Player:setHealth(val, add)

    if add then
        self.health = self.health + val
    else
        self.health = val
    end
    self.health = self.health > 1  and 1 or self.health < 0 and 0 or self.health

    ui.addTextArea(self.healthBarId, "", self.name, CONSTANTS.BAR_X, 340, CONSTANTS.BAR_WIDTH * self.health, 20, 0xff0000, 0xee0000, 1, false)

    ui.updateTextArea(2, "<p align='center'>" .. math.ceil(self.health * 100) .. "%</p>", self.name)
end

function Player:setMoney(val, add)
    if add then
        self.money = self.money + val
    else
        self.money = val
    end
    self.money = self.money < 0 and 0 or self.money
    ui.updateTextArea(1, "Money : $" .. self.money, self.name)
end

function Player:setXP(val, add)
    if add then
        self.xp = self.xp + val
    else
        self.xp = val
    end
    ui.addTextArea(self.xpBarId, "", self.name, CONSTANTS.BAR_X, 370, ((self.xp - calculateXP(self.level)) / (calculateXP(self.level + 1) - calculateXP(self.level)))  * CONSTANTS.BAR_WIDTH, 17, 0x00ff00, 0x00ee00, 1, false)
    ui.updateTextArea(3, "<p align='center'>Level " .. self.level .. " - " ..self.xp .. "/" .. calculateXP(self.level + 1) .. "XP", self.name)

end

function Player:levelUp()
    if self.xp >= calculateXP(self.level + 1) then
        self.level = self.level + 1
        self:setHealth(1.0, false)
        self:setMoney(5 * self.level, true)
        print("level up !" .. self.level .. " XP: " .. self.xp)
    end
end

function Player:useMed(med)
    if not (self.health >= 1) then
        self:setHealth(med:getRegain(), med:isAdding())
        print(tostring(med:isAdding()) .. " " .. med:getRegain())
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
    __call = function (cls, name, price, regain, add, uid, desc)
        return cls.new(name, price, regain, add, uid, desc)
    end,
})

function HealthPacks.new(name, price, regainVal, add, uid, desc)
    local self = setmetatable({}, HealthPacks)
    self.name = name
    self.price = price
    self.regainVal = regainVal
    self.add = add
    self.uid = uid
    self.description =  desc
    return self
end


function HealthPacks:getName() return self.name end
function HealthPacks:getPrice() return self.price end
function HealthPacks:getRegain() return self.regainVal end
function HealthPacks:isAdding() return self.add end
function HealthPacks:getDescription() return self.description end
function HealthPacks:getUID() return self.uid end

--class creation(HealthPacks) end

--game functions

function displayShop(target)
    local medicTxt = ""
    for id, medic in pairs(healthPacks) do
        --TODO: SET MEDICAL TEXT TO BE DISPLAYED IN THE SHOP
        medicTxt = medicTxt .. medic:getName()  .. " " .. medic:getRegain()  .. " Price:" .. medic:getPrice() .. "<a href='event:" .. medic:getUID() .."'> Buy</a><br>"
    end
    ui.addTextArea(100, "<p align='center'><font size='20'><b><J>Shop</J></b></font></p><br></br>" .. medicTxt, target, 200, 90, 400, 200, nil, nil, 1, true)
end

function calculateXP(lvl)
    return 2.5 * (lvl + 2) * (lvl - 1)
end

function setUI(name)
    --textAreas
    --work
    ui.addTextArea(0, "<a href='event:work'><br><p align='center'><b>Work!</b></p>", name, 5, 340, 45, 50, 0x324650, 0x000000, 1, true)
    --stats
    ui.addTextArea(1, "Money : $0", name, 6, CONSTANTS.STAT_BAR_Y, 785, 40, 0x324650, 0x000000, 1, true)
    --health bar area
    ui.addTextArea(2, "<p align='center'>100%</p>", name, CONSTANTS.BAR_X, 340, CONSTANTS.BAR_WIDTH, 20, nil, nil, 0.5, false)
    --xp bar area
    ui.addTextArea(3, "<p align='center'>Level 1  -  0/" .. calculateXP(2) .. "XP</p>", name, CONSTANTS.BAR_X, 370, CONSTANTS.BAR_WIDTH, 20, nil, nil, 0.5, true)
    --shop button
    ui.addTextArea(40, "<a href='event:shop'>Shop</a>", name, 740, 300, 36, 20, nil, nil, 1, true)

end

--event handling

function eventNewPlayer(name)
    players[name] = Player(name)
    setUI(name)
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
    elseif evt == "shop" then
        displayShop(name)
    elseif string.sub(evt, 1, 6) == "health"and players[name]:getMoney() - healthPacks[string.sub(evt, 8)]:getPrice() >= 0 then
        local pack = healthPacks[string.sub(evt, 8)]
        players[name]:useMed(pack)
        players[name]:setMoney(-pack:getPrice(), true)
    end
end

function eventLoop(t,r)
    for name, player in pairs(players) do
        player:setHealth(player:getHealthRate(), true)
    end
end


--event handling ends

--game logic

healthPacks['cheese'] = HealthPacks("Cheese", 5, 0.01, true, "health:cheese", "Just a cheese! to refresh yourself")
healthPacks['pizza'] =  HealthPacks("Cheese Pizza", 30, 0.05, true, "health:pizza", "dsjfsdlkgjsdk")


print("type" .. type(HealthPacks("", 32, 5)))

for name, player in pairs(tfm.get.room.playerList) do
    players[name] = Player(name)
end

setUI(nil)
