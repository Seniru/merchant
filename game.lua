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
local courses = {}
local closeButton = "<p align='right'><font color='#ff0000' size='13'><b><a href='event:close'>X</a></b></font></p>"
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
    self.learning = ""
    self.learnProgress = 0
    self.eduLvl = 1
    self.eduStream = ""
    self.degrees = {}
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
function Player:getLearningCourse() return self.learning end
function Player:getLearningProgress() return self.learnProgress end
function Player:getEducationLevel() return self.eduLvl end
function Player:getEducationStream() return self.eduStream end
function Player:getDegrees() return self.degrees end

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

function Player:setCourse(course)
  self.learning = course.name
  self.learnProgress = 0
  self.eduLvl = course.level
  self.eduStream = course.stream
end

function Player:addDegree(course)
  table.insert(self.degrees, course)
end

function Player:learn()
  if learning == "" then
    print("No course!")
  else
print(self.learning)
    if self.money > courses[self.learning].feePerLesson then
      self.learnProgress = self.learnProgress + 1
      self:setMoney(-courses[self.learning].feePerLesson, true)
      if self.learnProgress >= courses[self.learning].lessons then
        self:addDegree(self.learning)
        print("Graduated")
        self.learning = ""
        self.eduLvl = self.eduLvl + 1
      end
    end
  end
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
        self:setHealth(med.regainVal, med.adding)
    end
end

--class creation(Player) ends

--game functions

function displayShop(target)
    local medicTxt = ""
    for id, medic in pairs(healthPacks) do
        medicTxt = medicTxt .. medic.name  .. " " .. medic.regainVal  .. " Price:" .. medic.price .. "<a href='event:" .. medic.uid .."'> Buy</a><br>"
    end
    ui.addTextArea(100, closeButton .. "<p align='center'><font size='20'><b><J>Shop</J></b></font></p><br></br>" .. medicTxt, target, 200, 90, 400, 200, nil, nil, 1, true)
end

function displayCourses(target)
  local courseTxt = ""
  local p = players[target]
  for id, course in pairs(courses) do
    if p:getEducationLevel() == course.level and (p:getEducationStream() == course.stream or p:getEducationStream() == "") and learning ~= "" then
      courseTxt = courseTxt .. id .. " Fee: " .. course.fee .. " Lessons: " .. course.lessons .. " <a href='event:" .. course.uid .. "'>Enroll</a>'<br>"
    end
  end
  ui.addTextArea(200, closeButton .. "<p align='center'><font size='20'><b><J>Courses</J></b></font></p><br></br>" .. courseTxt, target, 200, 90, 400, 200, nil, nil, 1, true)
end

function calculateXP(lvl)
    return 2.5 * (lvl + 2) * (lvl - 1)
end

function HealthPack(_name, _price, _regainVal, _adding, _desc)
  healthPacks[_name] = {
    name = _name,
    price = _price,
    regainVal = _regainVal,
    adding = _adding,
    uid = "health:" .. _name,
    desc = _desc
  }
end

function Course(_name, _fee, _lessons, _level, _stream)
  courses[_name] = {
    name = _name,
    fee = _fee,
    lessons = _lessons,
    level = _level,
    stream = _stream,
    feePerLesson = _fee / _lessons,
    uid = "course:" .. _name 
  }
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
    ui.addTextArea(4, "<a href='event:shop'>Shop</a>", name, 740, 300, 36, 20, nil, nil, 1, true)
    --school button
    ui.addTextArea(5, "<a href='event:courses'>Learn</a>", name, 740, 270, 36, 20, nil, nil, 1, true)
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
    elseif evt == "courses" then
        if players[name]:getLearningCourse() == "" then
          displayCourses(name)
        else 
          players[name]:learn()
        end
    elseif evt == "close" then
        ui.removeTextArea(id, name)
    elseif string.sub(evt, 1, 6) == "health" and players[name]:getMoney() - healthPacks[string.sub(evt, 8)].price >= 0 then
        local pack = healthPacks[string.sub(evt, 8)]
        players[name]:useMed(pack)
        players[name]:setMoney(-pack.price, true)
    elseif string.sub(evt, 1, 6) == "course" then
        players[name]:setCourse(courses[string.sub(evt, 8)])
        ui.removeTextArea(id, name)    
    end
end

function eventLoop(t,r)
    for name, player in pairs(players) do
        player:setHealth(player:getHealthRate(), true)
    end
end

--event handling ends

--game logic

--creating and storing HealthPack tables
HealthPack("Cheese", 5, 0.01, true,  "Just a cheese! to refresh yourself")
HealthPack("Cheese Pizza", 30, 0.05, true, "dsjfsdlkgjsdk")
--creating and storing Course tables
Course("School", 20, 2, 1, "")
Course("Junior miner", 10, 4, 1, "")
Course("High School", 500, 20, 2, "")
Course("Cheese miner", 1000, 30, 3, "admin")
Course("Cheese trader", 2500, 30, 3, "bs")
Course("Cheese developer", 2500, 50, 3, "it")
Course("Cheese trader-II", 90000, 75, 4, "bs")
Course("Fullstack cheese developer", 10000, 70, 4, "it")

for name, player in pairs(tfm.get.room.playerList) do
    players[name] = Player(name)
end

setUI(nil)
