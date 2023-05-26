# Graduation Project (2017)

# ENHANCEMENT OF DISTRIBUTION SYSTEMS PERFORMANCE USING MODERN OPTIMIZATION TECHNIQUES

This project presents a procedure for determining the optimal placement of Distributed Generators (DGs) and capacitors in a distribution system. The objective of the procedure is to minimize power loss or total voltage deviation (TVD) while satisfying the security and operational constraints. The Archimedes Optimization Algorithm (AOA) is used to find the optimal locations and sizes of DGs and capacitors.

The procedure is tested on two systems: the 34-bus standard radial distribution system and the East Delta Network (EDN) distribution system, which is part of the Unified Egyptian Network (UEN).

## Results

The simulation results show that the proposed procedure can find the optimal solution for significant minimization in the objective function with more accuracy and efficiency, as compared to other methods. the proposed procedure is shown to be more efficient and accurate.

## Files

# find them in ./code/AOA_objects/

- `BF_gen.m`: Implementation of the backward/forward sweep algorithm
- `AOA.m`: Implementation of the Archimedes Optimization Algorithm
- `run.m`: Main program for running the proposed procedure
- `Networks`: creating objects for the networks we are testing the procedure on.

## Usage

# first step

to run the procedure first you need to create a network object of the network you want to optimize in the "Network.m" file

```Network_Name =Network(lines_data,loads_data,voltages_of_buses,Number_of_buses);

```

please make sure that the columns order is the same as networks IEEE_34 and EDN

# Second Step

open the " run.m" file and enter the modify the arguments of the call of AOA function and run

To run the procedure, simply run the `main.py` file with the appropriate data file (`34bus.xlsx` or `EDN.xlsx`). The program will output the optimal locations and sizes of DGs and capacitors, as well as the resulting power loss or TVD.

## References

- Archimedes Optimization Algorithm: A Novel Global Optimization Method for Engineering Design, A. Kaveh, H. R. Rostami and S. Talatahari, Advances in Engineering Software, 2014.
- Power System Analysis and Design, J. Duncan Glover, Mulukutla S. Sarma, Thomas J. Overbye, 6th Edition, 2017.
