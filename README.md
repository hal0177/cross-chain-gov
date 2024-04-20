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
3. Create ```Relayer```, chain A
4. Interface with Continuum Network
5. Create ```Receiver```, chain B