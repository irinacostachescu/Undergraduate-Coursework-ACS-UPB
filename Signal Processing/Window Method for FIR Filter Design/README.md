# Project 4: **Window Method for FIR Filter Design**
*The focus of the project was on the **Window Method** and how it can be used in order to design **FIR filters***/
Each directory contains the file/files necessary for solving the proposed tasks:
1. **Tema 1** required the **graphic representation** of the elementary windows, and their **impulse response** with the purpose of analyzing the percent of similarity with an ideal **low pass filter** (*in order to mantain the spectrum of the given signal unaltered, the spectrum of the window must be similar to the finite impulse function - convolution property*) 
2. **Tema 2** uses the windows designed previously for creating FIR filters of different **orders** and **cut-off frequencies**. How the characteristic of the filters vary with the **filter order** is also approached.
3. **Tema 3** is using the algorithm of FIR filters design in order to solve the problem of **designing a filter with given limits** (*in the low frequency area and high frequency area*). It contains two functions with the following purposes:
* Given the arguments: the impulse response of a FIR filter, and the pass band and stop band frequencies of a low pass filter, the function returns the maximum of the deviations between the ideal low pass filter and the designed one.
* Using the first function and given values for the deviations, the second program establishes if a designed filter respects the deviations imposed. It also illustrates in a graphic if the limits were respected or not.
4. **Tema 4** demands the implementation of a program which finds out the best FIR low pass filter. It has to
* Have the minimum order
* Have the minimum value for the sum of the deviations (the one in the pass band, and the one in the stop band)\
With the purpose of solving this task, each window is used to design filters and the order is varied until the minimum number is reached for each window. When two windows have the same minimum order, the sum of the deviations is computed and the comparison between the results gives the *winning* filter.
