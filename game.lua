--[[Dependencies]]--
--LineGraph-TFM
local a,b,c,d,e,f;local g='0123456789abcdef'function num2hex(h)local i=''while h>0 do local j=math.fmod(h,16)i=string.sub(g,j+1,j+1)..i;h=math.floor(h/16)end;return string.upper(i==''and'0'or i)end;function split(i,k)result={}for l in(i..k):gmatch("(.-)"..k)do table.insert(result,l)end;return result end;function c(m)local n=m[1]for o=1,#m do o=m[o]if o<n then n=o end end;return n end;function d(m)local p=m[1]for o=1,#m do o=m[o]if o>p then p=o end end;return p end;function e(m,q)local r={}for s,o in next,m do r[s]=q(o)end;return r end;function f(t,u,v)local w=table.insert;local r={}for x=t,u,v do w(r,x)end;return r end;local function y(z)return 400-z end;a={}a.__index=a;setmetatable(a,{__call=function(A,...)return A.new(...)end})function a.new(B,C,D,E)assert(#B==#C,"Expected same number of data for both axis")local self=setmetatable({},a)self.name=D;self:setData(B,C)self.col=E or math.random(0x000000,0xFFFFFF)return self end;function a:getName()return self.name end;function a:getDX()return self.dx end;function a:getDY()return self.dy end;function a:getColor()return self.col end;function a:getMinX()return self.minX end;function a:getMinY()return self.minY end;function a:getMaxX()return self.maxX end;function a:getMaxY()return self.maxY end;function a:getDataLength()return#self.dx end;function a:getLineWidth()return self.lWidth or 3 end;function a:setName(D)self.name=D end;function a:setData(B,C)self.dx=B;self.dy=C;self.minX=c(B)self.minY=c(C)self.maxX=d(B)self.maxY=d(C)end;function a:setColor(E)self.col=E end;function a:setLineWidth(F)self.lWidth=F end;b={}b.__index=b;b._joints=10000;setmetatable(b,{__call=function(A,...)return A.new(...)end})function b.init()tfm.exec.addPhysicObject(-1,0,0,{type=14,miceCollision=false,groundCollision=false})end;function b.handleClick(G,H,I)if I:sub(0,("lchart:data:["):len())=='lchart:data:['then local J=split(I:sub(("lchart:data:["):len()+1,-2),",")local K,L,M,N=split(J[1],":")[2],split(J[2],":")[2],split(J[3],":")[2],split(J[4],":")[2]ui.addTextArea(18000,"<a href='event:close'>X: "..M.."<br>Y: "..N.."</a>",H,K,L,80,30,nil,nil,0.5,false)elseif I=="close"then ui.removeTextArea(G)end end;function b.new(G,O,z,F,P)local self=setmetatable({},b)self.id=G;self.x=O;self.y=z;self.w=F;self.h=P;self.showing=false;self.joints=b._joints;b._joints=b._joints+10000;self.series={}return self end;function b:getId()return self.id end;function b:getDimension()return{x=self.x,y=self.y,w=self.w,h=self.h}end;function b:getMinX()return self.minX end;function b:getMaxX()return self.maxX end;function b:getMinY()return self.minY end;function b:getMaxY()return self.maxY end;function b:getXRange()return self.xRange end;function b:getYRange()return self.yRange end;function b:getGraphColor()return{bgColor=self.bg or 0x324650,borderColor=self.border or 0x212F36}end;function b:getAlpha()return self.alpha or 0.5 end;function b:isShowing()return self.showing end;function b:getDataLength()local Q=0;for R,i in next,self.series do Q=Q+i:getDataLength()end;return Q end;function b:show()self:refresh()local S,T=math.floor,math.ceil;ui.addTextArea(10000+self.id,"",nil,self.x,self.y,self.w,self.h,self.bg,self.border,self:getAlpha(),false)ui.addTextArea(11000+self.id,"<b>["..S(self.minX)..", "..S(self.minY).."]</b>",nil,self.x-15,self.y+self.h+5,50,50,nil,nil,0,false)ui.addTextArea(12000+self.id,"<b>"..T(self.maxX).."</b>",nil,self.x+self.w+10,self.y+self.h+5,50,50,nil,nil,0,false)ui.addTextArea(13000+self.id,"<b>"..T(self.maxY).."</b>",nil,self.x-15,self.y-10,50,50,nil,nil,0,false)ui.addTextArea(14000+self.id,"<b>"..T((self.maxX+self.minX)/2).."</b>",nil,self.x+self.w/2,self.y+self.h+5,50,50,nil,nil,0,false)ui.addTextArea(15000+self.id,"<br><br><b>"..T((self.maxY+self.minY)/2).."</b>",nil,self.x-15,self.y+(self.h-self.y)/2,50,50,nil,nil,0,false)local U=self.joints;local V=self.w/self.xRange;local W=self.h/self.yRange;for G,X in next,self.series do for Y=1,X:getDataLength(),1 do local Z=S(X:getDX()[Y]*V+self.x-self.minX*V)local _=S(y(X:getDY()[Y]*W)+self.y-y(self.h)+self.minY*W)local a0=S((X:getDX()[Y+1]or X:getDX()[Y])*V+self.x-self.minX*V)local a1=S(y((X:getDY()[Y+1]or X:getDY()[Y])*W)+self.y-y(self.h)+self.minY*W)tfm.exec.addJoint(self.id+6+U,-1,-1,{type=0,point1=Z..",".._,point2=a0 ..","..a1,damping=0.2,line=X:getLineWidth(),color=X:getColor(),alpha=1,foreground=true})if self.showDPoints then ui.addTextArea(16000+self.id+U,"<font color='#"..num2hex(X:getColor()).."'><a href='event:lchart:data:[x:"..Z..",y:".._..",dx:"..X:getDX()[Y]..",dy:"..X:getDY()[Y].."]'>█</a></font>",nil,Z,_,10,10,nil,nil,0,false)end;U=U+1 end end;self.showing=true end;function b:setGraphColor(a2,a3)self.bg=a2;self.border=a3 end;function b:setShowDataPoints(a4)self.showDPoints=a4 end;function b:setAlpha(a5)self.alpha=a5 end;function b:addSeries(X)table.insert(self.series,X)self:refresh()end;function b:removeSeries(D)for x=1,#self.series do if self.series[x]:getName()==D then table.remove(self.series,x)break end end;self:refresh()end;function b:refresh()self.minX,self.minY,self.maxX,self.maxY=nil;for s,i in next,self.series do self.minX=math.min(i:getMinX(),self.minX or i:getMinX())self.minY=math.min(i:getMinY(),self.minY or i:getMinY())self.maxX=math.max(i:getMaxX(),self.maxX or i:getMaxX())self.maxY=math.max(i:getMaxY(),self.maxY or i:getMaxY())end;self.xRange=self.maxX-self.minX;self.yRange=self.maxY-self.minY end;function b:resize(F,P)self.w=F;self.h=P end;function b:move(O,z)self.x=O;self.y=z end;function b:hide()for G=10000,17000,1000 do ui.removeTextArea(G+self.id)end;for G=self.id+16000,self.joints,1 do ui.removeTextArea(G+self.id)end;for Y=self.joints,self.joints+self:getDataLength()+5,1 do tfm.exec.removeJoint(Y)end;self.showing=false end;function b:showLabels(a4)if a4 or a4==nil then local a6=""for R,X in next,self.series do a6=a6 .."<font color='#"..num2hex(X:getColor()).."'> ▉<b> "..X:getName().."</b></font><br>"end;ui.addTextArea(16000+self.id,a6,nil,self.x+self.w+15,self.y,100,18*#self.series,self:getGraphColor().bgColor,self:getGraphColor().borderColor,self:getAlpha(),false)else ui.removeTextArea(16000+self.id,nil)end end;function b:displayGrids(a4)if a4 or a4==nil then local a7=self.h/5;for G,z in next,f(self.y+a7,self.y+self.h-a7,a7)do tfm.exec.addJoint(self.id+G,-1,-1,{type=0,point1=self.x..","..z,point2=self.x+self.w..","..z,damping=0.2,line=1,alpha=1,foreground=true,color=0xFFFFFF})end;tfm.exec.addJoint(self.id+5,-1,-1,{type=0,point1=self.x+self.w/2 ..","..self.y,point2=self.x+self.w/2 ..","..self.y+self.h,damping=0.2,line=2,alpha=1,foreground=true,color=0xFFFFFF})tfm.exec.addJoint(self.id+6,-1,-1,{type=0,point1=self.x..","..self.y+self.h/2,point2=self.x+self.w..","..self.y+self.h/2,damping=0.2,line=2,alpha=1,foreground=true,color=0xFFFFFF})end end;Series=a;LineChart=b;getMin=c;getMax=d;map=e;range=f
--Timers4TFM
local a={}a.__index=a;a._timers={}a._init=false;a._clock=0;setmetatable(a,{__call=function(b,...)return b.new(...)end})function a.init(c)if not a._init then a._init=true;a._clock=c end end;function a.process(d)a._clock=d;for e,f in next,a._timers do if f:isAlive()and f:getMatureTime()<=a._clock then f:call()if f.loop then f:reset()else f:kill()end end end end;function a.run(d)a.init(d)a.process(d)end;function a.new(g,h,i,j,...)local self=setmetatable({},a)self.id=g;self.callback=h;self.timeout=i;self.mature=a._clock+i;self.loop=j;self.args={...}self.alive=true;a._timers[g]=self;return self end;function a:getId()return self.id end;function a:getTimeout()return self.timeout end;function a:isLooping()return self.loop end;function a:getMatureTime()return self.mature end;function a:isAlive()return self.alive end;function a:setCallback(k)self.callback=k end;function a:addTime(c)self.mature=self.mature+c end;function a:setLoop(j)self.loop=j end;function a:setArgs(...)self.args={...}end;function a:call()self.callback(table.unpack(self.args))end;function a:kill()self.alive=false;self=nil end;function a:reset()self.mature=a._clock+self.timeout end;Timer=a

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.newGame([[<C><P F="0" L="1600"/><Z><S><S X="79" o="aac4d2" L="162" Y="165" c="4" H="334" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="169" o="6d9bb3" L="144" Y="201" c="4" H="285" P="0,0,0.3,0.2,-10,0,0,0" T="12"/><S X="296" o="285b74" L="52" Y="207" c="4" H="240" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="367" o="b5d8ea" L="113" Y="178" c="4" H="300" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="528" o="3d657a" L="61" Y="236" c="4" H="182" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="653" o="a5c5d6" L="197" Y="164" c="4" H="332" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="485" o="dfb218" L="78" Y="293" c="4" H="69" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="435" o="5a4c06" L="75" Y="277" c="4" H="104" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="338" o="0e67e7" L="12" Y="261" c="4" H="131" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="337" o="0b56c2" L="28" Y="253" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="338" o="324650" L="10" Y="155" H="22" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="338" o="0fa5f1" L="44" Y="201" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="338" o="0b56c2" L="17" Y="150" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="338" o="0e67e7" L="10" Y="128" c="4" H="38" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="721" o="7c99a7" L="111" Y="212" c="4" H="235" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="56" o="480312" L="10" Y="310" c="4" H="36" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="765" o="480312" L="10" Y="292" c="4" H="71" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="800" o="480312" L="10" Y="282" c="4" H="94" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="241" o="480312" L="10" Y="295" c="4" H="62" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="753" o="055111" L="26" Y="248" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="755" o="058419" L="10" Y="215" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="730" o="05be22" L="10" Y="256" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="769" o="83ae0b" L="20" Y="236" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="785" o="129226" L="10" Y="195" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="1053" Y="178" T="12" L="307" H="306" o="A3B6C0" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="1429" o="a5c5d6" L="180" Y="174" c="4" H="332" P="0,0,0.3,0.2,7,0,0,0" T="12"/><S X="799" o="a18600" L="1602" Y="361" H="78" P="0,0,0.3,0.2,0,0,0,0" T="12"/><S X="211" o="058419" L="15" Y="253" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="253" o="05be22" L="15" Y="288" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="234" o="058419" L="31" Y="272" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="54" o="05be22" L="20" Y="239" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="56" o="83ae0b" L="26" Y="266" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="79" o="05be22" L="10" Y="279" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="34" o="058419" L="20" Y="264" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="967" Y="269" T="12" L="280" H="110" o="465962" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="773" o="096717" L="28" Y="243" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="1056" Y="286" T="12" L="10" H="76" o="324650" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="828" o="129226" L="29" Y="219" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="804" o="058419" L="35" Y="232" c="4" H="10" P="0,0,0.3,0.2,0,0,0,0" T="13"/><S X="1293" Y="286" T="12" L="10" H="76" o="324650" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="1167" Y="153" T="12" L="458" H="191" o="67818F" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="1508" o="480312" L="10" Y="273" H="94" P="0,0,0.3,0.2,0,0,0,0" T="12" c="4"/><S X="1470" Y="199" T="13" L="31" H="41" o="1F6526" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="1495" Y="220" T="13" L="30" H="42" o="26CD52" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="1537" Y="226" T="13" L="28" H="27" o="13933F" P="0,0,0.3,0.2,0,0,0,0" c="4"/><S X="1511" Y="168" T="13" L="34" H="41" o="2E8030" P="0,0,0.3,0.2,0,0,0,0" c="4"/></S><D><DS X="431" Y="309"/></D><O/></Z></C>]])

--game variables

tips = {}

local CONSTANTS = {
    BAR_WIDTH = 735,
    BAR_X = 60,
    STAT_BAR_Y = 30
}

local year = 3000
local month = 1
local day = 1

local months = {"January", "February", "March", "April", "May", "June", "July", "Aughust", "September", "October", "November", "December"}


local players = {}
local healthPacks = {}
local courses = {}
local jobs = {}
local companies = {}
local tempData = {} --this table stores temporary data of players when they are creating a new job. Generally contains data in this order: tempPlayer = {jobName = 'MouseClick', jobSalary = 1000, jobEnergy = 0, minLvl = 100, qualification = "a pro"}

local closeButton = "<p align='right'><font color='#ff0000' size='13'><b><a href='event:close'>X</a></b></font></p>"
local nothing = "<br><br><br><br><p align='center'><b><R><font size='15'>Nothing to display!"
local cmds = [[
  <p align='center'><font size='20'><b><J>Commands</J></b></font></p>
  <b>!help:</b>  Displays this dialogue
  <b>!company <i>[company name]:</i></b> Displays the specified compnay
  <b>!p <i>[player name]</i> or !profile <i>[player name]</i></b> Displays information about the specified player
]]
local gameplay = [[
    <p align='center'><font size='20'><b><J>Game Play</J></b></font></p>
    TFM Clicker is a game <b>clicker</b> which is based on an office/working environment. Your goal is to earn money, buy companies, hire workers and be the best businessman in transformice!
    <b><u>Working:</u></b> You have to work to earn money. You just need to click the 'Work' button in the corner! When you work, it will result in reduction of your health. And also increase in your money. Different jobs have different salaries and energy costs!
    <b><u>Shop:</u></b>  Shop is the place you can buy usesful stuff <font size='8'>(that you all know ^_^)</font>. Bought items are stored temporarily in the inventory. You can use them to increase your health when neaded.
    <b><u>Learning:</u></b> Learning is the only way to get qualifications for some jobs. Higher educational qualifications would result in better jobs.
    <b><u>Companies:</u></b>  You can buy a company when you have enough money for it. You can use your company to create jobs and recruit workers. (And that will increase your profit more and more!!).
    ]]

local ab = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
local latestLotto = {}
local lottoWins = {}
local lottoBuyers = {}

local chart = LineChart(1, 944, 60, 450, 185)
local timer = Timer("time-sys", function()
    day = day + 1
    if day == 31 then
        day = 1
        month = month + 1
        companies["Atelier801"]:issueShares(50, "shaman")
        --updating the stock market dashboard
        for comp, data in next, companies do
            for i=1, 11, 1 do
                data.shareVal[i] = data.shareVal[i+1]
            end
            data.shareVal[12] = data.incomePerMonth / data.outstandingShares + 100
            data.chartSeries:setData(range(1, 12, 1), data.shareVal)
            data.incomePerMonth = 0
        end
        chart:showLabels()
        chart:show()
        --checking lottery winners
        latestLotto = {math.random(1, 100), math.random(1, 100), math.random(1, 100), ab[math.random(1, 26)]}
        checkLottoWinners()
        for name, wins in next, lottoWins do
            players[name]:setMoney(wins, true)
        end
        lottoBuyers = {}
        if month == 13 then
            month = 1
            year = year + 1
        end
    end
    ui.updateTextArea(12, "<p align='center'><b>YR " .. year .. "</b><br><b>" .. day .. "</b> of <b>" .. months[month] .. "</b></p>")
end, 1000, true)

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
    self.money = name == 'King_seniru#5890' and 100000 or 0
    self.title = "Newbie"
    self.titles = {[self.title]=true}
    self.health = 1.0
    self.healthRate = 0.002
    self.xp = 0
    self.level = 1
    self.learning = ""
    self.learnProgress = 0
    self.eduLvl = 1
    self.eduStream = ""
    self.degrees = {}
    self.job = "Cheese collector"
    self.ownedCompanies = {}
    self.company = "Atelier801"
    self.inventory = {}
    ui.addTextArea(1000, "", name, CONSTANTS.BAR_X, 340, CONSTANTS.BAR_WIDTH, 20, 0xff0000, 0xee0000, 1, true)
    ui.addTextArea(2000, "", name, CONSTANTS.BAR_X, 370, 1, 17, 0x00ff00, 0x00ee00, 1, true)
    return self
end

function Player:getName() return self.name end
function Player:getMoney() return self.money end
function Player:getHealth() return self.health end
function Player:getHealthRate() return self.healthRate end
function Player:getXP() return self.xp end
function Player:getLevel() return self.level end
function Player:getLearningCourse() return self.learning end
function Player:getLearningProgress() return self.learnProgress end
function Player:getEducationLevel() return self.eduLvl end
function Player:getEducationStream() return self.eduStream end
function Player:getDegrees() return self.degrees end
function Player:getOwnedCompanies() return self.ownedCompanies end
function Player:getInventory() return self.inventory end
function Player:getJob() return self.job end
function Player:getTitle() return self.title end
function Player:getTitles() return self.titles end

function Player:work()
    local job = jobs[self.job]
    if self.health - job.energy > 0 then
        self.setHealth(self, -job.energy, true)
        self:setMoney(job.salary + job.salary * self.eduLvl * 0.1, true)
        self:setXP(1, true)
        self:addTitle("Worker")
        companies[self.company]:setIncome(job.salary * 0.5, true)
        for name, shares in next, companies[self.company]:getShareHolders() do
            players[name]:setMoney(shares.shares * job.salary * 0.1, true)
        end
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
    ui.addTextArea(1000, "", self.name, CONSTANTS.BAR_X, 340, CONSTANTS.BAR_WIDTH * self.health, 20, 0xff0000, 0xee0000, 1, true)
    ui.updateTextArea(2, "<p align='center'>" .. math.ceil(self.health * 100) .. "%</p>", self.name)
end

function Player:setMoney(val, add)
    if add then
        self.money = self.money + val
    else
        self.money = val
    end
    self.money = self.money < 0 and 0 or self.money
    self:updateStatsBar()
end

function Player:setXP(val, add)
    if add then
        self.xp = self.xp + val
    else
        self.xp = val
    end
    ui.addTextArea(2000, "", self.name, CONSTANTS.BAR_X, 370, ((self.xp - calculateXP(self.level)) / (calculateXP(self.level + 1) - calculateXP(self.level)))  * CONSTANTS.BAR_WIDTH, 17, 0x00ff00, 0x00ee00, 1, true)
    ui.updateTextArea(3, "<p align='center'>Level " .. self.level .. " - " ..self.xp .. "/" .. calculateXP(self.level + 1) .. "XP", self.name)
end

function Player:setTitle(newTitle)
    if self.titles[newTitle] then
        self.title = newTitle
        self:updateStatsBar()
    end
end

function Player:addTitle(newTitle)
    if not self.titles[newTitle] then
        self.titles[newTitle] = "« " .. newTitle .. " »"
        tfm.exec.chatMessage("Congratulations, " ..  self.name .. " achieved a new title\n" .. self.titles[newTitle])
    end
end

function Player:setCourse(course)
    self.learning = course.name
    self.learnProgress = 0
    self.eduLvl = course.level
    self.eduStream = course.stream
    self:addTitle("Little Learner")
    ui.updateTextArea(5, "<a href='event:courses'><font size='15'><b>Learn</b></font></a>", self.name)
    ui.addTextArea(3000, "<p align='center'><b>Lessons left: 0 / " .. courses[self.learning].lessons .. "</b></p>", self.name, 480, 180, 300, 20, nil, nil, 0, false)
end

function Player:setJob(job)
    local jobRef = jobs[job]
    if jobRef.minLvl <= self.level and (jobRef.qualifications == nil or self.degrees[jobRef.qualifications] ~= nil) then
        companies[self.company]:removeMember(self.name)
        self.job = job
        self.company = jobRef.company
        companies[self.company]:addMember(self.name)
    end
end

function Player:addOwnedCompanies(comName)
    if not self.ownedCompanies[comName] then
        self:addTitle("Businessman")
        self.ownedCompanies[comName] = companies[comName]
    end
end

function Player:investTo(comName, amount, sharePurchase)
    if self.money < amount then
        tfm.exec.chatMessage('Not Enough money!', self.name)
    else
        if sharePurchase then
            if companies[comName]:getUnownedShares() < amount / 100 then
                tfm.exec.chatMessage("Company doesn't issue shares of the specified amount", self.name)
                return
            end
                companies[comName]:setShares(-amount / 100, true)
            end
        companies[comName]:addShareHolder(self.name, amount)
        self:setMoney(-amount, true)
        self:addOwnedCompanies(comName)
        self:addTitle("Investor")
        displayCompany(comName, self.name)
    end
end

function Player:addDegree(course)
    self:addTitle("Degree Holder")
    self.degrees[course] = courses[course]
end

function Player:learn()
    if not (self.learning == "") and self.money > courses[self.learning].feePerLesson then
        self.learnProgress = self.learnProgress + 1
        ui.updateTextArea(3000, "<b><p align='center'>Lessons left: " .. self.learnProgress .. " / " .. courses[self.learning].lessons .. "</b></p>", self.name)
        self:setMoney(-courses[self.learning].feePerLesson, true)
        if self.learnProgress >= courses[self.learning].lessons then
            self:addDegree(self.learning)
            self.learning = ""
            self.eduLvl = self.eduLvl + 1
            self:addTitle("Dedicated Learner")
        end
    end
end

function Player:levelUp()
    if self.xp >= calculateXP(self.level + 1) then
        self.level = self.level + 1
        self:setHealth(1.0, false)
        self:setMoney(5 * self.level, true)
        displayParticles(self.name, tfm.enum.particle.star)
        self:addTitle("Getting Experience")
    end
end

function Player:useMed(med)
    if not (self.health >= 1) then
        self:setHealth(med.regainVal, med.adding)
        displayParticles(self.name, tfm.enum.particle.heart)
    end
end

function Player:updateStatsBar()
    ui.updateTextArea(10, "<p align='right'>Money: $" .. formatNumber(self.money) .." </p> ", self.name)
    ui.updateTextArea(11, " Level: " .. self.level, self.name)
    ui.updateTextArea(1, "<br><p align='center'><b>" .. self.name .. "</b><br>« " .. self.title .. "»</p>", self.name)
end

function Player:grabItem(item)
    if self.inventory[item] == nil then
        self.inventory[item] = 1
    else
        self.inventory[item] = self.inventory[item] + 1
    end
end

function Player:useItem(item)
    if self.inventory[item] ~= nil then
        self.inventory[item] = self.inventory[item] - 1
    if self.inventory[item] < 1 then
        self.inventory[item] = nil
    end
  end
end

function Player:buyLottery(choices)
    local invalid = not choices:find("%s*%d+%s+%d+%s+%d+%s+[a-zA-Z]%s*")
    if invalid then
        return tfm.exec.chatMessage('Invalid input!', self.name)
    end
    choices = map(split(choices:gsub("%s+", " "), " "), function(x)
        if x:find("%d+") then
            local n = tonumber(x)
            if n < 0 or n > 100 then invalid = true end
            return n
        end
        if x:find("[a-zA-Z]") then return x:upper() end
        invalid = true
    end)
    if invalid then
        tfm.exec.chatMessage("Invalid input!")
    else
        self:setMoney(-20, true)
        if not lottoBuyers[self.name] then lottoBuyers[self.name] = {} end
        table.insert(lottoBuyers[self.name], choices)
        tfm.exec.chatMessage("Bought a lottery!", self.name)
    end
end

--class creation(Player) ends

--class creation(Company)
local Company = {}
Company.__index = Company
Company.__tostring = function(self)
    return "[name=" .. self.name .. ",owner=" .. self.owner .. "]"
end

setmetatable(Company, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function Company.new(name, owner)
    local self = setmetatable({}, Company)
    self.name = name
    self.owner = owner
    self.shareholders = {[owner]={capital=5000, shares=1.0}}
    self.capital = 5000
    self.members = {}
    self.jobs = {}
    self.unownedShares = 0
    self.outstandingShares = 50
    self.incomePerMonth = 0
    self.shareVal = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100}
    self.chartSeries = Series(range(1, 12, 1), self.shareVal, name)
    chart:addSeries(self.chartSeries)
    self.uid = "com:" .. name
    return self
end

function Company:getName() return self.name end
function Company:getOwner() return self.owner end
function Company:getShareHolders() return self.shareholders end
function Company:getMembers() return self.members end
function Company:getJobs() return self.jobs end
function Company:getUID() return self.uid end
function Company:getCapital() return self.capital end
function Company:getshareValory() return self.shareVal end
function Company:getChartSeries() return self.chartSeries end
function Company:getUnownedShares() return self.unownedShares end
function Company:getOutstandingShares() return self.outstandingShares end
function Company:getIncomePerMonth() return self.incomePerMonth end

function Company:addMember(name)
    if not self.members[name] then
        self.members[name] = true
    end
end

function Company:removeMember(name)
    self.members[name] = nil
end

function Company:addShareHolder(name, inCapital)
    self.capital = self.capital + inCapital
    local newCap = self.shareholders[name] == nil and inCapital or self.shareholders[name].capital + inCapital
    self.shareholders[name] = {capital=newCap, shares=newCap/self.capital}
    for n, d in next, self.shareholders do
        self.shareholders[n] = {capital=d.capital, shares=d.capital/self.capital}
    end
end

function Company:addCapital(amount)
    self.capital = self.capital + amount
    self.shareVal[month] = self.capital
end

function Company:issueShares(number, auth)
    if self.shareholders[auth] then
        self.unownedShares = self.unownedShares + number
    end
end

function Company:setShares(amount, add, category)
    if category == "outstanding" then
        self.outstandingShares = add and self.outstandingShares + amout or amount
    else
        self.unownedShares = add and self.unownedShares + amount or amount
    end
end

function Company:setIncome(amount, add)
    self.incomePerMonth = add and self.incomePerMonth + amount or amount
end

--class creation(Company) ends

--game functions

function displayShop(target, page)
    local medicTxt = ""
    for id, medic in next, {healthPacks[((page - 1) * 2) + 1], healthPacks[page * 2]} do
        medicTxt = medicTxt .. "<b><font size='13'>" .. medic.name  .. "</font></b><br><p align='right'><VP><a href='event:buy:" .. medic.uid .."'><b>| Buy |</b></a></VP></p>Price: " .. medic.price .. "  Energy: " .. (medic.regainVal * 100) .. "%<br>" .. medic.desc .. "<br><br>"
    end
    ui.addTextArea(100, closeButton .. "<p align='center'><font size='20'><b><J>Shop</J></b></font></p><br></br>" .. (medicTxt == "" and nothing or medicTxt), target, 200, 90, 400, 200, nil, nil, 1, true)
    ui.addTextArea(101, "<p align='center'><a href='event:page:shop:" .. page - 1 .."'>«</a></p>", target, 500, 310, 10, 15, nil, nil, 1, true)
    ui.addTextArea(102, "Page " .. page, target, 523, 310, 50, 15, nil, nil, 1, true)
    ui.addTextArea(103, "<p align='center'><a href='event:page:shop:" .. page + 1 .."'>»</a></p>", target, 585, 310, 15, 15, nil, nil, 1, true)
end

function displayCourses(target)
    local courseTxt = ""
    local p = players[target]
    for id, course in next, courses do
        if p:getEducationLevel() == course.level and (p:getEducationStream() == course.stream or p:getEducationStream() == "") and learning ~= "" then
            courseTxt = courseTxt .. "<b><font size='13'>" .. course.name .. "</font></b><VP><a href='event:" .. course.uid .. "'><b> | Enroll |</b></a></VP><br><font size='10'>(Fee: " .. course.fee .. " Lessons: " .. course.lessons .. ")</font><br>"
        end
    end
    ui.addTextArea(200, closeButton .. "<p align='center'><font size='20'><b><J>Courses</J></b></font></p><br></br>" .. (courseTxt == "" and nothing or courseTxt), target, 200, 90, 400, 200, nil, nil, 1, true)
end

function displayJobs(target, page)
    local jobTxt = ""
    local p = players[target]
    local qJobs = getQualifiedJobs(target)
    for id, job in next, {qJobs[((page - 1) * 2) + 1], qJobs[page * 2]} do
        jobTxt = jobTxt .. "<b><font size='13'>" .. job.name .. "</font></b><br><p align='right'><b><VP><a href='event:" .. job.uid .. "'> | Choose | </a></VP></b></p>Salary: " .. job.salary .. " Energy: " .. (job.energy * 100) .. "%<br>Offered by <b>" .. job.owner .. "</b> of <b>" .. job.company .. "</b><br><br>"
    end
    ui.addTextArea(300, closeButton .. "<p align='center'><font size='20'><b><J>Jobs</J></b></font></p><br><br>" .. (jobTxt == "" and nothing or jobTxt), target, 200, 90, 400, 200, nil, nil, 1, true)
    ui.addTextArea(301, "<p align='center'><a href='event:page:jobs:" .. page - 1 .."'>«</a></p>", target, 500, 310, 10, 15, nil, nil, 1, true)
    ui.addTextArea(302, "Page " .. page, target, 523, 310, 50, 15, nil, nil, 1, true)
    ui.addTextArea(303, "<p align='center'><a href='event:page:jobs:" .. page + 1 .."'>»</a></p>", target, 585, 310, 15, 15, nil, nil, 1, true)
end

function displayCompanyDialog(target)
    if not next(players[target]:getOwnedCompanies()) then
        ui.addPopup(400, 1, "<p align='center'>No owned companies<br>Do you want to own one?</p>", target, 300, 90, 200, true)
    else
        local companyTxt = ""
        local p = players[target]
        for name, company in next, p:getOwnedCompanies() do
            companyTxt = companyTxt .. "<b><a href='event:" .. company:getUID() .. "'>" .. company:getName() .. "</a></b><br>Members: " .. (#company:getMembers() == 0 and "-" or string.sub(table.tostring(company:getMembers()), 2, -3))
        end
        ui.addTextArea(400, closeButton .. "<p align='center'><font size='20'><b><J>My Companies</J></b></font></p><br><br>" .. companyTxt, target, 200, 90, 400, 200, nil, nil, 1, true)
        ui.addTextArea(401, "<a href='event:createCompany'>New Company</a>", target, 500, 310, 100, 20, nil, nil, 1, true)
    end
end

function displayCompany(name, target)
    if companies[name] ~= nil then
        local com = companies[name]
        local isOwner = false
        tempData[target].jobCompany = name
        local companyTxt = ""
        local members = ""
        for name, v in next, com:getMembers() do
            members = members .. name .. "<br>"
        end
        ui.addTextArea(400, closeButton .. "<p align='center'><font size='20'><b><J>" .. name .. "</J></b></font></p><br><br><b>Owner</b>: " ..  com:getOwner() .. "<br><b>Members</b>: <br>" .. members, target, 200, 90, 400, 200, nil, nil, 1, true)
        for n, _ in next, com:getShareHolders() do
            if n == target then isOwner = true end
        end
        if isOwner then
            ui.addTextArea(401, "<a href='event:createJob'>Create Job</a>", target, 500, 310, 100, 20, nil, nil, 1, true)
            ui.addTextArea(402, "<a href='event:invest:" .. com:getName() .. "'> Invest!</a>", target, 200, 310, 100, 20, nil, nil, 1, true)
            --add the relevant event
            ui.addTextArea(403, "<a href='event:issueShares:" .. com:getName() .. "'>Issue Shares</a>", target, 405, 310, 80, 20, nil, nil, 1, true)
        end
        ui.addTextArea(404, (com:getUnownedShares() == 0 and "<BL>Buy Shares</BL>" or "<a href='event:buyShares:" .. com:getName() .. "'> Buy Shares <font size='10'>(all: " .. com:getUnownedShares() .. ")</font></a>"), target, 315, 310, isOwner and 80 or 170, 20, nil, nil, 1, true)
    else
        ui.addPopup(404, 0, "<p align='center'><b><font color='#CB546B'>Company doesn't exist!", target, 300, 90, 200, true)
    end
end

function displayJobWizard(target)
    ui.addTextArea(500, closeButton .. [[<p align='center'><font size='20'><b><J>Job Wizard</J></b></font></p><br><br>
    <b>Job Name: </b><a href='event:selectJobName'>]] ..  (tempData[target].jobName == nil and "Select" or tempData[target].jobName) .. [[</a>
    <b>Salary: </b><a href='event:selectJobSalary'> ]] .. (tempData[target].jobSalary == nil and "Select" or tempData[target].jobSalary) .. [[</a>
    <b>Enery: </b><a href='event:selectJobEnergy'> ]] .. (tempData[target].jobEnergy == nil and "Select" or tempData[target].jobEnergy .. "%") .. [[</a>
    <b>Minimum Level: </b><a href='event:chooseJobMinLvl'>]] .. (tempData[target].minLvl == nil and "Select" or tempData[target].minLvl) .. [[</a>
    <b>Qualifcations: </b><a href='event:chooseJobDegree'>]] .. (tempData[target].qualification == nil and "Select" or tempData[target].qualification) .. [[</a><br>
    ]], target, 200, 90, 400, 200, nil, nil, 1, true)
end

function displayAllDegrees(target)
    local degreeTxt = ""
    for k, v in next, courses do
        degreeTxt = degreeTxt .. "<a href='event:degree:" .. v.name .. "'>" .. v.name .. "</a><br>"
    end
    ui.addTextArea(600, closeButton .. "<p align='center'><font size='20'><b><J>Choose a Degree</J></b></font></p>" .. degreeTxt, target, 200, 90, 400, 200, nil, nil, 1, true)
end

function displayInventory(target)
    local invTxt = ""
    for k, v in next, players[target]:getInventory() do
        invTxt = invTxt .. "<b><font size='12'>".. k .. "</font><a href='event:use:" .. k .."'><VP> | Use x" .. v .. " |</VP> </a></b> : <font size='10'>(Energy: " .. (find(k, healthPacks).regainVal * 100) .. "%)</font><br>"
    end
    ui.addTextArea(700, closeButton .. "<p align='center'><font size='20'><b><J>Inventory</J></b></font></p><br>" .. (invTxt == "" and nothing or invTxt), target, 200, 90, 400, 200, nil, nil, 1, true)
end

function displayTips(target)
    ui.addTextArea(800, tips[1], target, 6, 150, 120, 150, 0x324650, 0x000000, 1, true)
    ui.addTextArea(801, "«", target, 10, 315, 10, 15, nil, nil, 1, true)
    ui.addTextArea(802, "Page 1", target, 35, 315, 50, 15, nil, nil, 1, true)
    ui.addTextArea(803, "<p align='center'><a href='event:page:tip:2'>»</a></p>", target, 100, 315, 15, 15, nil, nil, 1, true)
end

function displayProfile(name, target)
    local up = upper(name)
    local p = players[name] or players[up] or players[up .. "#0000"] or players[target]
    if p then
        ui.addTextArea(900, closeButton .. 
        "<p align='center'><font size='15'><b><BV>" .. p:getName() .."</BV></b></font><br>« " .. p:getTitle() .. " »</p><br><b>Level:</b> " .. tostring(p:getLevel()) .. "<BL><font size='12'> [" .. tostring(p:getXP()) .. "XP / " .. tostring(calculateXP(p:getLevel() + 1)) .. "XP]</font></BL><br><b>Money:</b> $" .. formatNumber(p:getMoney()) .. "<br><br><b>Working as a</b> " .. p:getJob()
        , target, 300, 100, 200, 130, nil, nil, 1, true)
    end
end

function displayHelp(target, mode)
    ui.addTextArea(950, "<B><J><a href='event:cmds'>Commands</a>", target, 30, 130, 75, 20, 0x324650, 0x000000, 1, true)
    ui.addTextArea(951, "<a href='event:game'><B><J>Gameplay", target, 30, 95, 75, 20, 0x324650, 0x000000, 1, true)
    ui.addTextArea(952, closeButton .. (mode == "game" and gameplay or cmds), target, 100, 90, 600, 230, 0x324650, 0x000000, 1, true)
end

function displayTitleList(target)
    local titles = "Listing owned titles. Use !title NEW_TITLE to set a new title."
    for title, _ in next, players[target]:getTitles() do
        titles = titles .. "\n« " .. title .. " »"
    end
    tfm.exec.chatMessage(titles, target)
end

function displayLotto(target)
    local txt = "<p align='center'><font size='20'><b><J>Lotto Info</J></b></font><br><br><b>This month's winning lotto: </b>" .. ((#latestLotto == 0) and 'No drawings yet!' or latestLotto[1] .. ", " .. latestLotto[2] ..  ", " .. latestLotto[3] .. ", " .. latestLotto[4]) .. "<br><br>"
    txt = txt .. ((lottoWins[target] == nil or lottoWins[target] == 0) and "You have no wins in the past month!" or "You have won $" .. lottoWins[target] .. " in the past month") .. "</p>"
    ui.addTextArea(4000, closeButton .. txt, target, 200, 90, 400, 200, nil, nil, 1, true)
end

function calculateXP(lvl)
    return 2.5 * (lvl + 2) * (lvl - 1)
end

function getMaxSalary(comp)
    return companies[comp]:getCapital() * 0.1
end

function displayParticles(target, particle)
    tfm.exec.displayParticle(particle, tfm.get.room.playerList[target].x, tfm.get.room.playerList[target].y, 0, -2, 0, 0, nil)
    tfm.exec.displayParticle(particle, tfm.get.room.playerList[target].x - 10, tfm.get.room.playerList[target].y, 0, -3, 0, 0, nil)
    tfm.exec.displayParticle(particle, tfm.get.room.playerList[target].x + 10, tfm.get.room.playerList[target].y, 0, -2, 0, 0, nil)
    tfm.exec.displayParticle(particle, tfm.get.room.playerList[target].x + math.random(-15, 15) , tfm.get.room.playerList[target].y, 0, -1, 0, 0, nil)
end

function getQualifiedJobs(player)
    local p = players[player]
    local qjobs = {}
    for id, job in next, jobs do
        if p:getLevel() >= job.minLvl and (job.qualifications == nil or p:getDegrees()[job.qualifications] ~= nil) then
                table.insert(qjobs, job)
        end
    end
    return qjobs
end

function find(name, tbl)
    for k,v in ipairs(tbl) do
        if (v.name == name) then
            return v
        end
    end
    return nil
end

function createTip(tip, index)
    tips[index] = closeButton .. "<p align='center'><J><b>Tips!</b></J><br><br>" .. tip
end

function checkLottoWinners(p)
    if p then
        return lottoWins[p]
    end
    lottoWins = {}
    for name, lottos in next, lottoBuyers do
        local wins = 0
        for _, lotto in next, lottos do
            wins = wins + getWinPrice(lotto)
        end
        lottoWins[name] = wins
    end
end

function getWinPrice(lotto)
    local wins = 0
    if latestLotto[1] == lotto[1] and latestLotto[2] == lotto[2] and latestLotto[3] == lotto[3] and latestLotto[4] == lotto[4] then
        return 100000
    elseif (latestLotto[1] == lotto[1] and latestLotto[2] == lotto[2]) or (latestLotto[2] == lotto[2] and latestLotto[3] == lotto[3]) or (latestLotto[1] == lotto[1] and latestLotto[3] == lotto[3]) then
        wins = 5000
    elseif (latestLotto[4] == lotto[4]) then
        return wins + 1000
    end
    return wins
end

--[[copied from stackoverflow
  Credits: https://stackoverflow.com/users/1514861/ivo-beckers
  Question: https://stackoverflow.com/questions/1426954/split-string-in-lua
]]
function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function table.tostring(tbl)
    s = "["
    for k, v in next, tbl do
        s = s .. k .. ":" .. v .. ", "
    end
    return s .. "]"
end

function float(n, digits)
	digits = digits or 1
	return math.ceil(n * 10^digits) / 10^digits
end

function formatNumber(n)
    if n >= 1000000000000 then
        return float(math.floor(n / 100000000000),1) .. "T"
    elseif n >= 1000000000 then
        return float(math.floor(n / 100000000),1) .. "B"
    elseif n >= 1000000 then
        return float(math.floor(n / 100000),1) .. "M"
    elseif n >= 10000 then
        return float(math.floor(n / 1000),1) .. "K"
    end
    return float(n,1)
end

function upper(str)
	return string.upper(string.sub(str,1,1)) .. string.lower(string.sub(str,2))
end

function getTotalPages(type, target)
    if type == 'tip' then
        return #tips
    elseif type == 'shop' then
        return #healthPacks / 2 + (#healthPacks % 2)
    elseif type == 'jobs' then
        return #getQualifiedJobs(target) / 2 + (#getQualifiedJobs(target) % 2)
    end
    return 0
end

function updatePages(name, type, page)
    if not (page < 1 or page > getTotalPages(type, name)) then
        if type == 'tip' then
            ui.updateTextArea(800, tips[page] or "", name)
            ui.updateTextArea(801, "<a href='event:page:tip:" .. (page - 1) .. "'>«</a>", name)
            ui.updateTextArea(802, "<p align='center'>Page " .. page .. "</p>", name)
            ui.updateTextArea(803, "<a href='event:page:tip:" .. (page + 1) .. "'>»</a>", name)
        elseif type == 'shop' then
            displayShop(name, page)
        elseif type == 'jobs' then
            displayJobs(name, page)
        end
    end
end

function HealthPack(_name, _price, _regainVal, _adding, _desc)
    return {
        name = _name,
        price = _price,
        regainVal = _regainVal,
        adding = _adding,
        uid = "health:" .. _name,
        desc = _desc
    }
end

function Course(_name, _fee, _lessons, _level, _stream)
    return {
        name = _name,
        fee = _fee,
        lessons = _lessons,
        level = _level,
        stream = _stream,
        feePerLesson = _fee / _lessons,
        uid = "course:" .. _name
    }
end

function Job(_name, _salary, _energy, _minLvl, _qualifications, _owner, _company)
    return {
        name = _name,
        salary = _salary,
        energy = _energy,
        minLvl = _minLvl,
        qualifications = _qualifications,
        owner = _owner,
        company = _company,
        uid = "job:" .. _name
    }
end

function setUI(name)
    --textAreas
    --work
    ui.addTextArea(0, "<a href='event:work'><br><p align='center'><b>Work!</b></p>", name, 5, 340, 45, 50, 0x324650, 0x000000, 1, true)
    --stats
    --ui.addTextArea(1, name .. "<br>Money : $0 | Level 1", name, 6, CONSTANTS.STAT_BAR_Y, 785, 40, 0x324650, 0x000000, 1, true)
    ui.addTextArea(10, "<p align='right'>Money: $0 </p> ", name, 200, 25, 120, 20, nil, nil, 1, true)
    ui.addTextArea(11, " Level: 1", name, 480, 25, 120, 20, nil, nil, 1, true)
    ui.addTextArea(1, "<br><p align='center'><b>" .. name .. "</b><br>« Newbie »</p>", name, 325, 20, 150, 45, nil, nil, 1, true )
    --health bar area
    ui.addTextArea(2, "<p align='center'>100%</p>", name, CONSTANTS.BAR_X, 340, CONSTANTS.BAR_WIDTH, 20, nil, nil, 0.5, true)
    --xp bar area
    ui.addTextArea(3, "<p align='center'>Level 1  -  0/" .. calculateXP(2) .. "XP</p>", name, CONSTANTS.BAR_X, 370, CONSTANTS.BAR_WIDTH, 20, nil, nil, 0.5, true)
    --shop button
    ui.addTextArea(4, "<a href='event:shop'><b><font color='#000000' size='15'>Shop</font></b></a>", name, 100, 230, 50, 40, nil, nil, 0, false)
    --school button
    ui.addTextArea(5, "<a href='event:courses'><font size='15'><b>Enter</b></font></a>", name, 600, 270, 60, 20, nil, nil, 0, false)
    --jobs button
    ui.addTextArea(6, "<a href='event:jobs'>Jobs</a>", name, 740, 240, 36, 20, nil, nil, 1, true)
    --Company button
    ui.addTextArea(7, "<a href='event:company'>Company</a>", name, 740, 210, 36, 20, nil, nil, 1, true)
    --Tips buton
    ui.addTextArea(8, "<a href='event:tips'>Tips</a>", name, 740, 180, 36, 20, nil, nil, 1, true)
    --Inventory button
    ui.addTextArea(9, "<a href='event:inv'>Inventory</a>", name, 740, 150, 36, 20, nil, nil, 1, true)
    --Clock interface
    ui.addTextArea(12, "<p align='center'><b>YR " .. year .. "</b><br><b>" .. day .. "</b> of <b>" .. months[month] .. "</b></p>", name, 288, 180, 100, 100, nil, nil, 0, false)
    --Lottery board
    ui.addTextArea(13, "<p align='center'><a href='event:getLottery'>Buy Lottery!</a><br><br><a href='event:checkLotto'>Check</a></p>", name, 1530, 250, 50, 65, nil, nil, 1, false)
    LineChart.init()
    tfm.exec.addImage("16f2831a4b1.png", "_10", 60, 210) -- Shop image
    tfm.exec.addImage("16f285ae02c.png", "_18", 500, 100) -- School image (icon made by Dinosoft labs in 'flaticons.com')
    tfm.exec.addImage("16f3176f389.png", "_50", 1450, 260)-- Slot machine image (Icons made byNikita Golubev in flaticons.com)
    chart:showLabels()
    chart:setShowDataPoints(true)
    chart:show()
end

--event handling

function eventNewPlayer(name)
    players[name] = Player(name)
    tempData[name] = {}
    setUI(name)
    tfm.exec.respawnPlayer(name)
end

function eventPlayerDied(name)
    tfm.exec.respawnPlayer(name)
end

function eventTextAreaCallback(id, name, evt)
    LineChart.handleClick(id, name, evt)
    if evt == "work" then
        players[name]:work()
    elseif evt == "tips" then
        displayTips(name)
    elseif evt == "cmds" then
        displayHelp(name, "cmds")
    elseif evt == "game" then
        displayHelp(name, "game")
    elseif string.sub(evt, 1, 4) == "page" then
        local args = split(evt, ":")
        updatePages(name, args[2], tonumber(args[3]))
    elseif evt == "shop" then
        displayShop(name, 1)
    elseif evt == "courses" then
        if players[name]:getLearningCourse() == "" then
            displayCourses(name)
        else
            players[name]:learn()
        end
    elseif evt == "jobs" then
        displayJobs(name, 1)
    elseif evt == "inv" then
        displayInventory(name)
    elseif evt == "close" then
        ui.removeTextArea(id, name)
        if id == 400 then
            ui.removeTextArea(401, name)
            ui.removeTextArea(402, name)
            ui.removeTextArea(403, name)
            ui.removeTextArea(404, name)
        elseif id == 800 then
            ui.removeTextArea(801, name)
            ui.removeTextArea(802, name)
            ui.removeTextArea(803, name)
        elseif id == 100 then
            ui.removeTextArea(101, name)
            ui.removeTextArea(102, name)
            ui.removeTextArea(103, name)
        elseif id == 300 then
            ui.removeTextArea(301, name)
            ui.removeTextArea(302, name)
            ui.removeTextArea(303, name)
        elseif id == 952 then
            ui.removeTextArea(950, name)
            ui.removeTextArea(951, name)
        end
    elseif evt == "company" then
        displayCompanyDialog(name)
    elseif evt == "createJob" then
        if tempData[name].jobName == nil or tempData[name].jobSalary == nil or tempData[name].jobEnergy == nil or tempData[name].minLvl == nil then
            displayJobWizard(name)
        else
            local tempCompany = tempData[name].jobCompany
            jobs[tempData[name].jobName] = Job(tempData[name].jobName, tempData[name].jobSalary, tempData[name].jobEnergy / 100, tempData[name].minLvl, tempData[name].qualification, name, tempData[name].jobCompany)
            tempData[name] = {jobCompany = tempCompany}
            ui.removeTextArea(500, name)
        end
    elseif evt == "createCompany" then
        ui.addPopup(400, 1, "<p align='center'>Do you want to own a new company</p>", name, 300, 90, 200, true)
    elseif evt == "selectJobName" then
        ui.addPopup(601, 2, "<p align='center'>Please choose a name", name, 300, 90, 200, true)
    elseif evt == "selectJobSalary" then
        ui.addPopup(602, 2, "<p align='center'>Please choose the salary (<i>Should be a number lesser than " .. getMaxSalary(tempData[name].jobCompany) .."</i>)", name, 300, 90, 200, true)
    elseif evt == "selectJobEnergy" then
        ui.addPopup(603, 2, "<p align='center'>Please select the energy (<i>Should be a number in range 0 - 100</i>)", name, 300, 90, 200, true)
    elseif evt == "chooseJobMinLvl" then
        ui.addPopup(604, 2, "<p align='center'>Please select the minimum level (<i>Should be a number</i>", name, 300, 90, 200, true)
    elseif evt == "chooseJobDegree" then
        displayAllDegrees(name)
    elseif evt == "getLottery" then
        ui.addPopup(1000, 2, "<p align='center'>Please enter your choices (3 numbers between 0 and 100 and a letter) separated by spaces. <br><i>eg:15 20 30 B</i></p>", name, 300, 90, 200, true)
    elseif evt == "checkLotto" then
        displayLotto(name)
    elseif evt:gmatch("%s+:%s+") then
        local type = split(evt, ":")[1]
        local val = split(evt, ":")[2]
        if type == "buy" and players[name]:getMoney() - find(split(evt, ":")[3], healthPacks).price >= 0 then
            local pack = find(split(evt, ":")[3], healthPacks)
            players[name]:setMoney(-pack.price, true)
            players[name]:grabItem(pack.name)
        elseif type == "course" then
            players[name]:setCourse(courses[val])
            ui.removeTextArea(id, name)
        elseif type == "job" then
            players[name]:setJob(val)
            eventTextAreaCallback(id, name, "close")
        elseif type == "com" then
            displayCompany(val, name)
        elseif type == "degree" then
            tempData[name].qualification = val
            local e = math.ceil((tempData[name].jobSalary or 1)/ getMaxSalary(tempData[name].jobCompany) * 100) - courses[val].level * 2
            tempData[name].jobEnergy = e < 0 and 1 or e
            ui.removeTextArea(id, name)
            displayJobWizard(name)
        elseif type == "use" then
            players[name]:useItem(val)
            players[name]:useMed(find(val, healthPacks))
            displayInventory(name)
        elseif type == "invest" then
            ui.addPopup(700, 2, "Please enter the amount to invest. (Should be a valid number)", name, 300, 90, 200, true)
            tempData[name].investing = val
        elseif type == "buyShares" then
            local comp = companies[val]
            ui.addPopup(800, 2, "This company issues " .. comp:getUnownedShares() .. " shares.<br>Enter the amount you want to purchase (1 share = $100)", name, 300, 90, 200, true)
            tempData[name].investing = val
        elseif type == "issueShares" then
            ui.addPopup(900, 2, "Please specify the number of shares you want to issue (Should be a valid number)", name, 300, 90, 200, true)
            tempData[name].issuesSharesIn = val
        end
    end
end

function eventPopupAnswer(id, name, answer)
    if id == 400 and answer == 'yes' then --for the popup creating a compnay
        if players[name]:getMoney() < 5000 then
        ui.addPopup(450, 0, "<p align='center'><b><font color='#CB546B'>Not enough money!", name, 300, 90, 200, true)
    else
        ui.addPopup(450, 2, "<p align='center'>Please choose a name<br>Price: $5000<br>Click submit to buy!</p>", name, 300, 90, 200, true)
    end
    elseif id == 450 and answer ~= '' then --for the popup to submit a name for the company
        if companies[answer] then
            tfm.exec.chatMessage('Company already exists!')
            return
        end
        companies[answer] = Company(answer, name)
        players[name]:setMoney(-5000, true)
        players[name]:addOwnedCompanies(answer)
        displayCompany(answer, name)
    elseif id == 601 and answer ~= '' then --for the popup to submit the name for a new job
        tempData[name].jobName = answer
        displayJobWizard(name)
    elseif id == 602 and tonumber(answer) and tonumber(answer) < getMaxSalary(tempData[name].jobCompany) then --for the popup to choose the salary for a new job
        tempData[name].jobSalary = tonumber(answer)
        tempData[name].jobEnergy = math.ceil(tempData[name].jobSalary / getMaxSalary(tempData[name].jobCompany) * 100)
        displayJobWizard(name)
    elseif id == 603 and tonumber(answer) and tonumber(answer) > 0 and tonumber(answer) <= 100 then --for the popup to choose the energy for the job
        tempData[name].jobEnergy = tonumber(answer)
        tempData[name].jobSalary = tempData[name].jobEnergy * getMaxSalary(tempData[name].jobCompany) / 100
        displayJobWizard(name)
    elseif id == 604 and tonumber(answer) then --for the popup to choose the minimum level for the job
        tempData[name].minLvl = tonumber(answer)
        local e = math.ceil((tempData[name].jobSalary or 1)/ getMaxSalary(tempData[name].jobCompany) * 100) - tempData[name].minLvl
        tempData[name].jobEnergy = e < 0 and 1 or e
        displayJobWizard(name)
    elseif id == 700 and tonumber(answer) then --for the investment popups
        players[name]:investTo(tempData[name].investing, tonumber(answer))
    elseif id == 800 and tonumber(answer) then
        players[name]:investTo(tempData[name].investing, tonumber(answer) * 100, true)
    elseif id == 900 and tonumber(answer) then
        companies[tempData[name].issuesSharesIn]:issueShares(tonumber(answer), name)
        displayCompany(tempData[name].issuesSharesIn, name)
    elseif id == 1000 then
        players[name]:buyLottery(answer)
    end
end

function eventChatCommand(name, msg)
    if string.sub(msg, 1, 7) == "company" then
        displayCompany(string.sub(msg, 9), name)
    elseif string.sub(msg, 1, 7) == "profile" then
        displayProfile(string.sub(msg, 9), name)
    elseif string.sub(msg, 1, 1) == "p"  then
        displayProfile(string.sub(msg, 3), name)
    elseif msg == "help" then
        displayHelp(name, "game")
    elseif string.sub(msg, 1, 5) == "title" then
        if string.sub(msg, 7) == "" then
            displayTitleList(name)
        else
            players[name]:setTitle(string.sub(msg, 7))    
        end
    end
end

function eventLoop(t,r)
    Timer.run(t)
    for name, player in next, players do
        player:setHealth(player:getHealthRate(), true)
    end
end

--event handling ends

--game logic

players["shaman"] = Player("shaman")
companies["Atelier801"] = Company("Atelier801", "shaman")

--creating tips
createTip("You Need $5000 To Start A New Company!", 1)
createTip("You Gain Money From Your Workers!", 2)
createTip("Look At The Stats of The Company Before You Apply for it!", 3)
createTip("The Better The Job The Better The Income!", 4)
createTip("Buy Items From The Shop To Gain Health!", 5)
createTip("Some Jobs Needs A Specific Degree", 6)
createTip("To Level Up You Need To Work!", 7)
createTip("The Higher The Level The Higher The Health", 8)
createTip("The Stats Of A Company Can Be Seen By Anyone", 9)
createTip("While Working Your Health Bar Goes Down", 10)
createTip("Patience is The Key To This Game.", 11)
createTip("Your Stats Can Be Seen At The Top Of The Map!", 12)
createTip("You Can Buy Multiple Companies!", 13)
createTip("Once You Have A Job You Can't Quit!", 14)
createTip("Your Health will be Refreshed when You Level Up", 15)
createTip("Recruit More Players to Have More Salary!", 16)
createTip("Try your Best to Own a Company", 17)
createTip("Make Sure You Consider About Energy and Salary When Choosing a Job", 18)
createTip("The Red Bar Displays Your Health, While the Green Bar Displays your XP Percentage", 19)
createTip("Chat With Your Friends When You Are Out of Health", 20)
createTip("Use Your Brain and Take Correct Decisions!", 21)
createTip("If Your Job Seems to Take More Energy, Try to Choose Another!", 22)
createTip("Consider About Your Health When Working", 23)
createTip("When Taking A Course, You will Need to Pay Per Lesson Only. So Try to Enroll For the One With Higher Lessons", 24)
createTip("You Can Apply to Jobs According to Your Level and Degrees", 25)
createTip("The Better Stats You Have The Better The Job You Can Have!", 26)
createTip("Report Bugs To Developers", 27)
createTip("The Game is More Fun with More Players", 28)
createTip("Click Tips When You Need Help", 29)
createTip("The Health Refreshes Every Moment <3", 30)


--creating and storing HealthPack tables
table.insert(healthPacks, HealthPack("Cheese", 5, 0.01, true,  "Just a cheese! to refresh yourself"))
table.insert(healthPacks, HealthPack("Candy", 10, 0.02, true, "Halloween Treat!"))
table.insert(healthPacks, HealthPack("Apple", 15, 0.025, true, "A nutritious diet from shaman"))
table.insert(healthPacks, HealthPack("Pastry", 30, 0.06, true, "King's favourite food"))
table.insert(healthPacks, HealthPack("Lasagne", 100, 0.1, true, "Shh!!! Beware of Garfield :D"))
table.insert(healthPacks, HealthPack("Cheese Pizza", 130, 0.15, true, "Treat from Italy - with lots of cheeese inside !!!"))
table.insert(healthPacks, HealthPack("Magician`s Portion", 250, 0.25, true, "Restores 1/4 th of your health."))
table.insert(healthPacks, HealthPack("Rotten Cheese", 300, 0.35, true, "Gives you the power of vampire <font size='5'>(disclaimer)This won't make you a vampire</font>"))
table.insert(healthPacks, HealthPack("Cheef`s food", 500, 0.5, true, "Restores half of your health (Powered by Shaman)"))
table.insert(healthPacks, HealthPack("Cheese Pizza - Large", 550, 0.55, true, "More Pizza Power!"))
table.insert(healthPacks, HealthPack("Vito`s Pizza", 700, 0.6, true, "World's best pizza!"))
table.insert(healthPacks, HealthPack("Vito`s Lasagne", 750, 0.8, true, "World's best lasagne!"))
table.insert(healthPacks, HealthPack("Ambulance!", 999, 1, false, "Restores your health back! (Powered by Shaman!)"))

--creating and storing Course tables
courses["School"] = Course("School", 20, 2, 1, "")
courses["Junior Sports Club"] = Course("Junior Sports Club", 10, 4, 2, "")
courses["High School"] = Course("High School", 500, 20, 3, "")
courses["Cheese mining"] = Course("Cheese mining", 1000, 30, 4, "admin")
courses["Cheese trading"] = Course("Cheese trading", 2500, 30, 4, "bs")
courses["Cheese developing"] = Course("Cheese developing", 2500, 50, 4, "it")
courses["Law"] = Course("Law", 35000, 80, 5, "admin")
courses["Cheese trading-II"] = Course("Cheese trading-II", 90000, 75, 5, "bs")
courses["Fullstack cheese developing"] = Course("Fullstack cheese developing", 40000, 70, 5, "it")
--creating and stofing Job tables
jobs["Cheese collector"] = Job("Cheese collector", 10, 0.05, 1, nil, "shaman", "Atelier801")
jobs["Junior miner"] = Job("Junior miner", 25, 0.1, 3, nil, "shaman", "Atelier801")
jobs["Cheese producer"] = Job("Cheese producer", 50, 0.15, 7, nil, "shaman", "Atelier801")
jobs["Cheese miner"] = Job("Cheese miner", 250, 0.2, 10, "Cheese mining", "shaman", "Atelier801")
jobs["Cheese trader"] = Job("Cheese trader", 200, 0.2, 12, "Cheese trading", "shaman")
jobs["Cheeese developer"] = Job("Cheese developer", 300, 0.3, 12, "Cheese developing", "shaman", "Atelier801")
jobs["Cheese wholesaler"] = Job("Cheese wholesaler", 700, 0.2, 15, "Cheese trading-II", "shaman", "Atelier801")
jobs["Fullstack cheese developer"] = Job("Fullstack cheeese developer", 9000, 0.4, 15, "Fullstack cheese developing", "shaman", "Atelier801")

for name, player in next, tfm.get.room.playerList do
    players[name] = Player(name)
    setUI(name)
    tempData[name] = {}
end

for id, cmd in next, {"company", "p", "profile", "help", "title"} do
    system.disableChatCommandDisplay(cmd, true)
end
