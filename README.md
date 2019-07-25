# TFM Clicker 

## Section 1: Introduction

TFM clicker is a transformice module built with lua. This is a simple **clicker** which is based in a office/working environment.

### How to play?

To run a lua script you must have atleast 1000 gathered cheese and the power to run scripts in your tribe house (and a tfm account of course!)
If you haven't fulfilled the above requirments, ask somebody with the right powers 👍

**Step 1:** 
type */lua* in the chat box and paste the script in it.
**Step 2:**
Submit the code to play the game. More information about the game can be found inside the game.

## Section 2: Documentation

`CONSTANTS` - Defines constants that are frequently used
   **Fields**
* `HEALTH_BAR_WIDTH` *(400)* - The Default width of the health bar
 * `HEALTH_BAR_X` *(150)* - The 'x' value of the health bar
* `STATS_BAR_Y` *(30)* - The 'y' position of the stats bar

`players` Table for storing `Player` objects in the room
`healthPacks` Tables for storing `HealthPacks` objects defined

**`Player`** - Class for defining properties and methods for players
**Meta Methods**
 * `__tostring(player)`  Triggers when a `Player` object calls `tostring()` method
 * `__call(name)` Calls the constructor `Player.new(name)` when the class is called as a method
  
**Fields**
* `name` The name of the player
* `money` The amount of money with the player. Initial value is 0
* `health` The health of the player. Ranges from *0.0* to *1.0*. Initial value is *1.0*
* `healthBarId` The id of the text area related to the player
* `healthRate` Amount of health gain per `0.5s`. Initial value is 0.002
 
**Methods**
* `:getName()` returns the field `name`
* `:getMoney()` returns the field `money`
* `:getHealth()` returns the field `health`
* `:getHealthBarId()`  returns the field `healthBarId`
* `:getHealthRate()` returns the field `healthRate`
* `:work()` defins the actions to be performed when the player is working. Generally include increasing money and reducing health.
* `:setHealth(val, add)` 
  - `val` (Integer) - The value to be added
  - `add` (Boolean) - If true the value will be added to the health. If false set the health to the specified value
* `useMed(med)` - *NOT IMPLEMENTED*
   - `med` (Medicine) - The medicine to be used

***DOCUMENTATION AND README TO BE COMPLETED!!! CONTRIBUTIONS ARE ALWAYS WELCOME 😊***



