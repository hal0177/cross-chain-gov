# Continuum Governor

## Project Notes

### Description

A cross-chain governance system (based on OpenZeppelin Governor). Allows a Governor contract on one chain to use
governance votes to change state in contracts on other chains.

### Contract Overview

- ```MyGovernor``` contract on chain A (source chain): participants vote to alter state on another chain
- ```C3ProposalDispatch``` contract on chain A: receives and processes the details of the cross-chain call
- Target contract on chain B (destination chain): where the state gets altered

### Project Steps

1. Create ```MyGovernor```, chain A
2. Create ```TimelockController```, chain A
3. Create ```VotesToken```, chain A
4. Create ```C3ProposalDispatch```, chain A
5. Interface with Continuum Network
6. Create Target, chain B

### Cross-chain Process

1. Make proposal to Governor
2. Votes, waiting periods, etc.
3. When the proposal is passed, instead of executing on source chain, it executes the tx as a C3Call on the same chain as voted on.
