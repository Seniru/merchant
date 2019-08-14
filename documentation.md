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
`__call (name)` Triggers when the table is called as a function.  Calls `Player.new(name)` internally. 

### Static methods
`Player.new(name)`
 - Creates and returns a new Player object.  
 - Arguments-  *name*:  Name of the player
### Class methods
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
| :setHealth(val, add) | `void` | *val*:`number` Amount of health to be changed<br><br>*add*:`boolean` If `true` the val will be added to the health. Otherwise set the health to the val| Sets/changes the health |
| :setMoney(val, add) | `void` | *val*:`number` Amount of money to be changed<br><br>*add*:`boolean` If `true` the val will be added to the money. Otherwise set the money to the val |
