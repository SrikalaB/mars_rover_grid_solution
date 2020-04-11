### Mars Rover Problem Solution
A ruby script written to facilitate the mars rover movement as per movement instructions.

### Table of Contents
1. [Requirements](#markdown-header-requirements)
2. [Setting up the script](#markdown-header-setting-up-the-script)
    1. [From source code](#markdown-header-from-source-code)
3. [Input specifications](#markdown-header-input-specifications)
4. [Usage](#markdown-header-usage)
    1. [Example - Interactive Method](#markdown-header-usage-interactive-method)
    2. [Example - Input json file method](#markdown-header-input-json-file-method)

### Requirements
Ruby: MRI 1.9+ (Tested on Ruby 2.6.3)

### Setting up the script

#### From source code
Clone the repo and cd into "mars_rover_solution" folder.
Install all required dependencies as follows
`$> bundle install`
  
### Input specifications
- Plateau grid size to be input as two integers separated by a space.
    - maximum x coordinate - Integer or 0
    - maximum y coordinate - Integer or 0
    Example: ` 5 5`
- Rover Start position specification
    - Rover's x coordinate - Integer or 0
    -  Rover's y coordinate - Integer or 0
    - Rover's orientation - N, S, E or W 
    To station the rover at position 2 on x axis, 3 on y axis facing north:
    Use: ` 2 3 N`
    N represents North, S - South,  E - East, W - West
- Rover movement instructions
    - L = Turn Left
    - R = Turn Right
    - M = Move forward
    Input instructions separated by a space
    Example: `L M R M R R`

### Usage
```
Usage: ruby bin/rover_control.rb --interactive
Usage: ruby bin/rover_control.rb --file=/path/to/jsonfile
    -i, --interactive                Run interactively to enter input
    -f, --file=FILE                  Input json file with instructions.
    -h, --help                       Prints this help
``` 

#### Usage: Interactive Method:
Example:

```
ruby bin/rover_control.rb --interactive
Enter the uppermost right corner coordinates of the plateau grid. (Example input: 7 7):
10 10

Enter the start postion and orientation of the rover you want to control (Example input: 2 2 N):
          OR
Type 'exit' to quit program
3 5 S
Enter instructions to move rover to desired location:
L M R M M
----Position of rover after move is: 4 3 S ----


Enter the start postion and orientation of the rover you want to control (Example input: 2 2 N):
          OR
Enter exit to quit program
exit

The final rover positions are:
4 3 S
```

####  Usage: Input json file method
In order to perform bulk rover movements on the grid, one can use the json file method.
The convention used is same as explained in the input specifications section. An array of rovers can be passed as shown in the sample file below:

input.json

```
{
  "grid": {
    "max_x": 5,
    "max_y": 5
  },
  "rovers": [
    {
      "name": "rover1",
      "initial_x": "1",
      "initial_y": "2",
      "orientation": "N",
      "move_instructions": "L M L M L M L M M"
    },
    {
      "name": "rover2",
      "initial_x": "3",
      "initial_y": "3",
      "orientation": "E",
      "move_instructions": "M M R M M R M R R M"
    }
  ]
}
```

Usage: ruby bin/rover_control.rb --file=input.json

```
----Position of rover after move is: 1 3 N rover1----

----Position of rover after move is: 5 1 E rover2----


The final rover positions are:
1 3 N rover1
5 1 E rover2
```