# Graduation Project (2017)

# ENHANCEMENT OF DISTRIBUTION SYSTEMS PERFORMANCE USING MODERN OPTIMIZATION TECHNIQUES

This project presents a procedure for determining the optimal placement of Distributed Generators (DGs) and capacitors in a distribution system. The objective of the procedure is to minimize power loss or total voltage deviation (TVD) while satisfying the security and operational constraints. The Archimedes Optimization Algorithm (AOA) is used to find the optimal locations and sizes of DGs and capacitors.

The procedure is tested on two systems: the 34-bus standard radial distribution system and the East Delta Network (EDN) distribution system, which is part of the Unified Egyptian Network (UEN).

## Results

The simulation results show that the proposed procedure can find the optimal solution for significant minimization in the objective function with more accuracy and efficiency, as compared to other methods. the proposed procedure is shown to be more efficient and accurate.

## Files
## find them in ./
- `master_grad_book.pdf`: the graduation project book contains all the details about the project and its results

## find them in ./code/AOA_objects/

- `BF_gen.m`: Implementation of the backward/forward sweep algorithm
- `AOA.m`: Implementation of the Archimedes Optimization Algorithm
- `run.m`: Main program for running the proposed procedure
- `Networks`: creating objects for the networks we are testing the procedure on.

# Usage

## first step

to run the procedure first you need to create a network object of the network you want to optimize in the "Network.m" file

```
Network_Name =Network(lines_data,loads_data,voltages_of_buses,Number_of_buses);

```

please make sure that the columns order is the same as networks IEEE_34 and EDN

## Second Step

open the " run.m" file and enter the modify the arguments of the call of AOA function and run
