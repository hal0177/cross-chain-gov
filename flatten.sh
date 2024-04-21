#! /bin/bash

mkdir -p build/source/ build/destination/
forge flatten src/source/MyGovernor.sol --output build/source/MyGovernor.sol
forge flatten src/source/C3ProposalDispatch.sol --output build/source/C3ProposalDispatch.sol
forge flatten src/source/VotesToken.sol --output build/source/VotesToken.sol

forge flatten src/destination/NameWall.sol --output build/destination/NameWall.sol
