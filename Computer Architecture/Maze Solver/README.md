# Project 2: **Maze Solver**

This project required the development of a program which browses a **maze** to find the exit with the following assumptions:
* The maze is represented by a 64x64 matrix
* The cells have the values 0 (free path) or 1 (wall)
* The algortihm used for finding the exit is the *right-hand rule*
* The start point can be anywhere
* From the start point, there is only one path that can be taken
* The path already traveled will be marked with the value 2
* The reading and writing operations must be done synchronous
* There is only one exit

The problem is solved using a **finite state machine** as a **synchronous sequential circuit**. The matrix is given into a file and it can't be cached. Therefore, in order to know what value is stored in a specific cell, the signal *maze_oe* must be activated (*maze_oe = 1*). The response of the circuit is going to be readable only at the next clock cycle (*next state in the finite state machine*).
In order to write "2" on the traveled path, same rules apply, but this time *maze_we = 1* needs to be used.\
When the exit is found, signal *done* becomes 1

The information found in the Maze Solver folder contains:
1. maze.v
* the implementation of the finite state machine
2. test.data
* the given maze *(64x64 matrix)*
3. top.v
*
4. test.v
* 
