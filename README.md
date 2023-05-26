# grad_pro
# Optimal Placement of DGs and Capacitors using Archimedes Optimization Algorithm

This project presents a procedure for determining the optimal placement of Distributed Generators (DGs) and capacitors in a distribution system. The objective of the procedure is to minimize power loss or total voltage deviation (TVD) while satisfying the security and operational constraints. The Archimedes Optimization Algorithm (AOA) is used to find the optimal locations and sizes of DGs and capacitors.

## Methodology

The proposed procedure uses the backward/forward sweep (BFS) algorithm for load flow calculations. The AOA is then applied to find the optimal placement of DGs and capacitors. The procedure is tested on two systems: the 34-bus standard radial distribution system and the East Delta Network (EDN) distribution system, which is part of the Unified Egyptian Network (UEN).

## Results

The simulation results show that the proposed procedure can find the optimal solution for significant minimization in the objective function with more accuracy and efficiency, as compared to other methods. The obtained results are compared with other methods, and the proposed procedure is shown to be more efficient and accurate.

## Files

- `BFS.py`: Implementation of the backward/forward sweep algorithm
- `AOA.py`: Implementation of the Archimedes Optimization Algorithm
- `main.py`: Main program for running the proposed procedure
- `34bus.xlsx`: Data for the 34-bus standard radial distribution system
-`EDN.xlsx`: Data for the East Delta Network distribution system
- `README.md`: Description of the project and procedure

## Usage

To run the procedure, simply run the `main.py` file with the appropriate data file (`34bus.xlsx` or `EDN.xlsx`). The program will output the optimal locations and sizes of DGs and capacitors, as well as the resulting power loss or TVD.

## Requirements

This project requires Python 3 and the following libraries:
- `numpy`
- `pandas`
- `scipy`

## References

- Archimedes Optimization Algorithm: A Novel Global Optimization Method for Engineering Design, A. Kaveh, H. R. Rostami and S. Talatahari, Advances in Engineering Software, 2014.
- Power System Analysis and Design, J. Duncan Glover, Mulukutla S. Sarma, Thomas J. Overbye, 6th Edition, 2017.
