# CSE 150A Homework 7 | Mini-Project <br>
Nicholas Smith <br>
March 12, 2020

### Overview
The purpose of this project to explore and analyze an application of Reinforced Learning in a popular computer game - <b>Minecraft</b>. This project is structured in the following way:

Note: MC = Minecraft, RL = Real Life

1. Hardware - entities in the game that control how the game functions. 
    - EEPROM (MC): small storage device that can be flashed from a computer
    - HDD (MC): drive needed for the computer to operate
    - RAM (MC): needed for the computer to operate
    - Monitor (MC): needed to interact with the computer
    - Keyboard (MC): needed to interact with the computer
    - CPU (MC): needed for the computer to operate
    - Drone (MC): entity that can runs programs and move around the game
    - Computer Case (MC): needed to hold all of the computer parts
2. Software - code that will be required for this project
    > LUA BIOS (MC) - program (written in Lua) that allows the computer to boot up
    > OpenOS (MC) - operating system for the computer (mimics a shell environment)
    > Visual Studio Code (RL) - where programs are developed and then copied into a text file in-game
    > Text Editor (MC) - used in the game to develop solutions

![Sample computer output using OpenComputers](https://www.google.com/url?sa=i&url=https%3A%2F%2Fmc-mods.org%2Fopencomputers-mod%2F&psig=AOvVaw3VvLEHTyY6brtvJb7Xl9oL&ust=1584063748652000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCND94b3nk-gCFQAAAAAdAAAAABAb)

As seen in the above list, all of the programs for this project will be programmed in Lua. Two of the programs used were taken directly from GitHub and are primarily meant to ease the process of debugging the drone and uploading new code. Please see the <i><b>REFERENCES</i></b> section at the bottom of the page to review these functions.