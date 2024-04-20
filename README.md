# Continuum Governor

## Project Notes

### Description

A cross-chain governance system (based on OpenZeppelin Governor). Allows a Governor contract on one chain to use
governance votes to change state in contracts on other chains.

### Contract Overview

1. ```Governor``` contract on chain A (source chain)
2. ```Relayer``` contract on chain A
3. ```Receiver``` contract on chain B (destination chain)
4. Target contract on chain B

### Project Steps

1. Create ```Governor```, chain A
2. Create ```Relayer```, chain A
3. Interface with Continuum Network
3. Create ```Receiver```, chain B