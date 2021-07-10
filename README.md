# Case Simulator

Case Simulator is a prototype for a gambling simulation game. In Case Simulator the player will open cases to get items that can be sold, equipped, and even collected. Items in Case Simulator are gun skins, knife skins, and stickers.

Gun skins are simply just a paint job for a gun. Knife skins are a paint job for a knife. Stickers are stickers you can put on your gun to customize it for even increase its value.

The code is pretty readable since it's written in the GDScript language. GDScript is a high-level scripting language for the Godot game engine. GDScript was made to resemble python while providing better performance than languages like python and lua.

Case Simulator stores item variables in .json files. Every case, skin, and sticker in the game has its own .json file. To determine what items are in cases, the game looks for the case file of the case the player wants to open and gets the value of the skins variable in the file. The skins variable contains a list of all of the skins that can be obtained from the case.

When opening a case in Case Simulator a few things happen.
1. The game creates a random number to determine what rarity item to give the player.
2. The game creates another random number to determine which item within that rarity to give the player.
3. The game creates one last random number to determine the condition of the item.
4. The item is then given to the player

To help make development of this game easier I created my own tool that allows me to make skins and items. The reason I made the tool is to save time. The steps for me to make a new item without the tool are, find the skins folder, create the skinname.json file, edit skinname.json and type {"name":"myawesomeskin", etc.} The tool I created allows me to enter the skin's data into text fields and then click one button to add it to the skins folder.

Case Simulator includes mini-games such as coin flip. Coin flip is a simple 50/50 gamble in which the player will tell the game how much money they want to bet and if the side they bet on wins they get double their bet back. If the player bets on the wrong side, they lose the bet.

Another mini-game in Case Simulator is Tower. Tower is a game of guessing. There are 3 rows of buttons. Each button hides either a bet multiplier or a bomb that makes you lose the game and your bet. The player starts off by picking one row in the bottom column and clicking that button. Then the player moves to the next row if they got a bet multiplier. The player can cash-out at anypoint they want, so long as they don't lose.
