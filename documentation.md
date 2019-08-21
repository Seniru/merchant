# Documentation

## class `Player`
The class that defines different fields and methods for players 

### Fields
| Name | Type | Description |
| --- | --- | --- |
| name | `string` | The name of the player |
| money | `number` | The money with the player |
| health | `number` | The health of the player. Ranges from 0.0 to 1.0 |
| healthRate | `number` | The amount of health regain per 500ms |
| xp | `number` | The XP points the player has |
| level | `integer` | The level of the player |
| learning | `string` | The current course the player is taking. |
| learningProgress | `integer` | The number of lessons taken in the current course |
| eduLvl | `integer` | The educational level |
| eduStream | `string` | The education stream the player following |
| degrees | `table` | A table which stores the completed courses of the player
| job | `string` | The job of the player. Default is 'cheese collector' |
| boss | `string` | The player that the current player (object) is working for. Default is 'shaman' |
| company | `string` | The company which renders the currentjob that the player is working on. Default is 'Atelier801'| 
|ownedCompanies | `table` | A table which consists of companies the player has owned |

### Meta Methods
`__tostring(self)` Triggers when a Player object is indexed inside tostring() method. 
`__call(name)` Triggers when the table is called as a function.  Calls `Player.new(name)` internally. 

### Static methods
`Player.new(name)`
 - Creates and returns a new Player object.  
 - Arguments-  *name*:  Name of the player
### Instance methods
| Method | Return Tupe | Arguments | Description |
| --- | --- | --- | --- |
| :getName() | `string` | | Returns the name of the player | 
| :getMoney() | `number` | | Returns the amount of the money player has |
| :getHealth() | `number` | | Returns the health of the player|
| :getHealthRate () | `number` | | Returns the amount of health regain per 500ms |
| :getXP() | `number` | | Returns the XP points of the player |
| :getLevel() | `integer` | |Returns the level of the player |
| :getLearningCourse() | `string` | | Returns the current learning course of the player | 
| :getLearninProgress() | `integer` | | Returns the number of lessons competed in the current learning course |
| :getEducationLevel () | `integer` | | Returns the educational level of the player |
| :getEducationStream() | `string` | | Returns the educational stream of the player |
| :getDegrees() | `table` | | Returns the degrees of the player |
| :getOwnedCompanies() | `table` | | Returns the companies that owned by the player |
| :getBoss() | `string` | | Returns the boss of the current referring player |
| :work() | `void` | | Works according to the player's current job. Results in increase of money and reduction in health/energy |
| :setHealth(val, add) | `void` | val:`number` Amount of health to be changed<br><br>*add*:`boolean` If `true` the val will be added to the health. Otherwise set the health to the val| Sets/changes the health |
| :setMoney(val, add) | `void` | val:`number` Amount of money to be changed<br><br>*add*:`boolean` If `true` the val will be added to the money. Otherwise set the money to the val | Sets/changes money |
| :setXP(val, add) | `void` | val:`number` Amount of XP to be changed<br><br>add:`boolean` If `true` the val will be added to XP. Otherwise set XP to val |
| :setCourse(course) | `void` | course:`string` The  course to be set | Changes the current learning course |
| :setJob(job) | `void` | job:`string` The job to be set | Changes the current job of the playr |
| :addOwnedCompanies(comName) | `void` | comName:`string` The new company owned by the player | Adds the company name specified to the owned companies list |
| :addDegree(course) | `void` | course:`string` The name of the degree | Adds a new degree to the degree list |
| :learn() | `void` | | Imitates the learning. This will cause in reduction of money and increase in education level, change in education stream or change in learning progress |
| :levelUp() | `void` | | Level up the player if the player has got enough XP to the next level |
| :useMed(med) | `void` | med:`string` The medicine to be used | Use the Health Pack and changes the health of the plater accordingly. |
| :updateStatsBar() | `void` | | Updates the stats relavant to the player |



## class `Company` 
This class contains fields and different methods to create a new company,  create a new job, recruit members and different other tasks.

### Fields

| Field | Type | Description |
| --- | --- | --- |
| name | `string` | The name of the company |
| owner | `string` | The owner of the company |
| members | `table` | A table of strings which contains the names of the members of the company |
| jobs | `table` | A table which includes all the jobs rendered by the company |
| uid | `string` | The unique id of the current company. UIDs are starting from 'com:' and followed by the company name |

### Meta methods

`tostring(self)` Triggers when a Company object is indexed inside tostring() method. 
`__call(name, owner)` Triggers when the table is called as a function.  Calls `Company.new(name, owner)` internally. 

### Static methods

`Company.new(name, owner)` 
 - Creates and returns a new Company object/table. 
 - Args
   - name: The name of the company
   - owner: The owner of the company.


### Instance methods

| Name | Return type | Parameters | Description |
| --- | --- | --- | --- |
| :getName() | `string` | | Returns the name of the company |
| :getOwner() | `string` | | Returns the owner of the company |
| :getMembers() | `table` | | Returns a table of strings which contain the names of the members |
| :getJobs() | `table` | | Returns a table of strings which contain the jobs created by the company |
| :getUID() | `string` | | Returns the Unique ID of the company |
| :addMember(name) | `void` | name:`string` The name of the member which should be added | Adds a member to the company |
| :removeMember(name) | `void` | name:`string` The name of the member which should be removed from the company | Removes a member from the company |

### Other Fields

| Name | Type | Value(s) | Description |
| --- | --- | --- | --- |
| CONSTANTS | `table` | `BAR_WIDTH`: 735<br> `BAR_X`: 60<br> `STAT_BAR_Y`: 30 | Defines a table of constants that are used oftenly in the srcipt |
| players | `table` | | Holds `Player` objects |
| healthPacks | `table` | | Holds `HealthPack` tables |
| courses | `table` | | Holds `Course` tables |
| jobs | `table` | | Holds `Job` tables |
| companies | `table` | | Holds `Company` objects |
| tempData | `table` | | Holds temporary data of players |
| closeButton | `string` | `"<p align='right'><font color='#ff0000' size='13'><b><a href='event:close'>X</a></b></font></p>"` | String containing data for close buttons which can be used inside textareas to close them. |
| 


### Other Methods

| Name | Return type | Parameters | Description |
| --- | --- | --- | ---- |
| displayShop(target) | `void` | target:`string` The player which the shop should be displayed | Displays the shop to the target |
| displayCourses(target) | `void` | target:`string` The playre which the courses should be displayed | Displays the courses to the target |
| displayJobs(target) | `void` | target:`string` The player which the jobs should be displayed | Displays the jobs to the target |
| displayCompanyDialog(target) | `void` | target:`string` The player which the company dialog should be displayed | Displays the company dialog to the target |
| displayCompany(name, target) | `void` |  name:`string` The name of the company <br> target:`string` The player which the company should be displayed | Displays the company to the target |
| displayJobWizard(target) | `void` | target:`string` The name of the player which the job wizard should be displayed | Displays the job wizard to the player |
| displayAllDegrees(target) | `void` | target:`string` The name of the player which the degrees whould be displayed | Displays all the degrees to the player. Purpose of this is to used in creating a new job |
| calculateXP(lvl) | `number` | lvl:`integer` The level | Calculates and returns the XP corresponding to the given level |
| displayParticles(target, particle) | `void` | target:`string` The target player <br> particle:`integer` The particle ID | Displays particle near the target |
| find(name, tbl) | `object|nil` | name:`object` The object<br> tbl:`table` The table to be checked | Finds the given name in the given table and returns the object related to the name in it. Returns `nil` if not found |
| createTip(tip, index) |  `void` | tip:`string` The tip <br> index:`integer` The index that the tip should occupy in the tips table | Create and stores a tip |
| table.indexOf(t, object) | `integer` | t:`table`: The table to be searched <br>object:`object` The object | Returns the index of the object in the specified table |
| split(s, delimeter) | `table` | s:`string` The input string<br> delimeter:`regex|string` The pattern which the string should be splitted | Splits the string according to the pattern |
| table.tostring(tbl) | `string` | tbl:`table` The input table | Returns a key, value string version of the input table |
| formatNumber(n) | `string` | n:`number` The input number | Formats and returns the number in more readable format |
| HealthPack(\_name, \_price, \_regainVal, \_adding, \_desc) | `table` | \_name:`string` The name of the health pack<br>\_price:`integer` The price<br>\_regainVal:`number` The regain value<br>\_adding:`boolean` If `true` this pack will add health to the player. Otherwise it will set the health to the regain value<br> \_desc:`string` Description | Creates and returns a HealthPack table |
| Course(\_name, \fee, \lessons, \level, \stream) | `table` | \_name:`string` The name of the course<br>\_fee:`integer` The fee of the course<br>\_lessons:`integer` Number of lessons<br>\_level:`integer` The education level corresponding to this course<br> \_stream:`string` The stream which the course follows | Creates and returns a Course table |
| Job(\_name, \_salary, \_energy, \_minLvl, \_qualifications, \_owner, \_company) | `table` | \_name:`string` The name of the job<br>\_salary:`integer` The salary<br>\_energy:`number` Energy cost for the work<br>\_minLvl:`integer` Minimum level of a player to do the work<br> \_qualifications:`string` The qualification of the player to do this job <br>\_owner:`string` The player who renders the job<br>\_company:`string` The company which renders the job | Creates and returns a Job table |
| setUI(name) | `void` | name:`string` The name of the player which the UI should be set | Sets the UI for the player |
