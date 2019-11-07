# Deltarune Raspberry Pi/Circuit Sword Port
A port that allows running Deltarune Chapter 1 on the Circuit Sword raspberry-pi based console.   

## Installation Instructions:

1. Download [deltarune.sh](https://github.com/Kneesnap/deltarune-circuit-sword/blob/master/deltarune.sh), and save it to /home/pi/RetroPie-Setup/scriptmodules/ports/deltarune.sh
2. Run the installation script. (RetroPie Setup -> Manage Packages -> Experimental Packages -> deltarune -> Install)
3. Reboot your system. It will now show up under the "Ports" menu in RetroPie.

## Installation on Raspberry Pi (NOT CIRCUIT SWORD):
I haven't tested, but you can probably just download the tar.gz in the [releases section](https://github.com/Kneesnap/deltarune-circuit-sword/releases/download/latest/deltarune.tar.gz),
and run the Deltarune executable. It might work out of the box, I am not sure.  
It is possible to run this on a Raspberry Pi Zero, but I built this specifically for the Raspberry Pi 3.  
If it turns out to be too intensive on the Pi Zero, I could make an alternative version which has lower quality textures to work better on the Pi Zero.  
Unfortunately, even though it runs on the Pi Zero, certain DIY consoles like the MintyPi will not be able to run this.  
This is because the MintyPi's screen buffer program (Some variant of fbcp) does not support dispmanx, or the video mode required to make this run at full-speed.  


## How was this made? Can this be done on other games?
I originally ported Undertale, but due to Undertale not being free, I cannot give the files required to make it work.  
I would love to give a guide on how to do this, but unfortunately I don't think there's a be all end all guide for this.  
  
A rough outline of what you'll need to do is:  
  
1. Create a project exporter that will let you export any GameMaker Studio game back into a GameMaker project which can be open in GameMaker. For legal reasons, these should not be shared.  
2. Use the "Deltarune" executable bundled in the .tar.gz in the releases section. This is a GMS runner I modified to run Undertale+Deltarune on Raspberry Pi. It has some quirks, and it's GMS version 1.0 build 466, so you will need to make some changes to the project for it to work.  
3. Using the GMAssetCompiler bundled in GMS1 v466, you can build your project. You may want to lower the size of texture pages if your game freezes on you and does not respond.  
4. Compatibility changes.  

List of changes you will need to make (Likely an incomplete list):  
 - Replace all instances of game_end() with a script you create called game_stop(). The script you make should have an error inside it, such as using a non-existant error. This is unfortunately because the runner is buggy and needs an error to exit.  
 - For the first 5 frames of a new room, disable drawing. For some bizarre reason, this crashes the runner. I believe it may be having to do with dynamic sprite management. Use draw_enable_drawevent(false); to disable. It would be best to put this on a persistent object that has an event for room start, then an alarm set to 5, which will enable it.  
 - The method variable_global_exists does not work. It should be replaced with code that works without this functionality. This function will crash when run.   
 - Add gamepad functions for each keyboard function. Otherwise, you can't play with a controller. The circuit sword button ids are non-standard for some reason, so if you want, so I listed them below.  
  
And, there could easily be more issues which I have not discovered yet.  
ini files seem to have some strange behavior, so don't be surprised if you run into that.
 
## Bugs:
Not everything has been tested fully, if you run into a problem, please submit an issue [here](https://github.com/Kneesnap/deltarune-circuit-sword/issues).

### Known Bugs:
 - Some rooms have weird views, for instance when Toriel drives you to school, upon entering the school, the camera is offset in the wall.
 
## Extra Information:
Your save-file is located at ~/.config/ For me, this is /home/pi/.config/

Circuit Sword Button Ids for GameMaker: Studio:
```
DPAD-UP: 12295
DPAD-DOWN: 4103
DPAD-LEFT: 12294
DPAD-RIGHT: 4102
A: 0
B: 1
X: 3
Y: 2
START: 4
SELECT: 5
SHOULDER L: 6
SHOULDER R: 7
```
If you need help finding other buttons, I'd recommend asking me for help or write some GML code that lets scan a range of button ids to find ones that are changing when you press the button you're looking for.


### Special Thanks:
Toby Fox - Creating Undertale + Deltarune. Even if you don't like my work, I love yours!  
krzys-h - Creating [UndertaleModTool](https://github.com/krzys-h/UndertaleModTool/), which made this possible.  
YoYoGames - Creating GameMaker: Studio, and the original (albeit broken) Raspberry Pi runner.  
Kite - Designing the Circuit Sword, and using a screen buffer program which is compatible with dispmanx.
