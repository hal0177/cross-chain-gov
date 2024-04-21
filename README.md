# Continuum Governor

## Project Notes

### Description

A cross-chain governance system (based on OpenZeppelin Governor). Allows a Governor contract on one chain to use
governance votes to change state in contracts on other chains.

### Contract Overview

- ```Governor``` contract on chain A (source chain)
- ```Relayer``` contract on chain A
- ```Receiver``` contract on chain B (destination chain)
- Target contract on chain B

### Project Steps

1. Create ```Governor```, chain A
2. Create ```VotesToken```, chain A
3. Create ```GovRelayer```, chain A
4. Interface with Continuum Network
5. Create ```Receiver```, chain B

### Cross-chain Process

1. Make proposal to governor
2. votes etc.
3. When the proposal is passed, instead of executing on source chain, it executes the tx as a C3Call.