Ghox MOF Ver.
=============

This is a simple binary modification of Toaplan's "Ghox" software that adds support for several input schemes.

Ghox originally uses a novel spinner control mounted on top of a two-way joystick, and the player moves by a combination of these input devices. As this control scheme is unusual and it may not be possible to mount it on some control panels, a version of Ghox that simply uses traditional joystick input also exists. If you own one and want the other, it is necessary to exchange the program data accordingly.

Building
--------

The following tools and data are needed to assemble the patched data:

* htts://github.com/mikejmoffitt/romtools, for `bsplit`
* The Macro Assembler AS (as `asl`)
* `ghox.zip` for original program data (not included)

Installation
------------

This software is for use on a Ghox PCB that has the spinner input peripheral PCB mounted in the corner.

To use it, build and then burn the program data onto appropriately sized EPROMs and install them into sockets u10 and u11 on the Ghox PCB.

Usage
-----

When the game detects joystick input data for the left and right directions, it gets set into Joystick Mode. Once in Joystick Mode, the joystick is used to handle all player movement, and the speed values match that of the joystick ROM set. Furthermore, Button 1 acts as a 1.5x speed multiplier as it does in that version.
If the joystick is not pushed, then the game will read spinner data normally.
The behavior of the demo mode is not affected, and its codepath is actually more similar to that of Joystick Mode to begin with.

Independent of Joystick Mode is a new feature, Traditional Spinner Mode. In this mode, Button 3 is used to control up/down movement, and the player does not need to use the joystick up/down inputs at all. This mode exists to make the game playable with an Arkanoid-style spinner, as opposed to the eclectic original setup.
To use this mode, Set the normally unused DIP Switch 2.8 to ON. Then, if button 3 is pressed, the player will move to the top of the playfield. If it is released, the player will "return to home" to the bottom of the field.

Joystick Mode and Traditional Spinner Mode may be used in conjunction, though it would be more of a novelty than a useful configuration.

License
-------

Freely use the binary data on Ghox hardware. Do not distribute this or derivative work without giving credit. Do not sell this data in any form. I don't own Ghox and it is unlikely that you do either.
