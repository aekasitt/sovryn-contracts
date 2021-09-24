#!/usr/bin/env python3.7
# coding:utf-8
# Copyright (C) 2019-2021 All rights reserved.
# FILENAME:  update-contracts.sh
# VERSION: 	 1.0
# CREATED: 	 2021-09-24 13:38
# AUTHOR: 	 Sitt Guruvanich <aekazitt@gmail.com>
# DESCRIPTION: Locate Contracts and Interfaces from main DistributedCollective/Sovryn-smart-contracts repo.
#
# HISTORY:
#*************************************************************
### Move Contracts and Interfaces to temporary folders in case of failure ###
mv ./contracts ./tmp_contracts
mv ./interfaces ./tmp_interfaces
### Create temporary folder for the contract cloning ###
mkdir tmp
cd tmp
### Initiate a separate git repository in this temporary directory ###
git init
### Use sparse checkout to only get desired sub-folders from the repository ###
git config core.sparsecheckout true
echo "contracts/*" >> .git/info/sparse-checkout
echo "interfaces/*" >> .git/info/sparse-checkout
### Download contracts and interfaces from DistributedCollective ###
git remote add origin git@github.com:DistributedCollective/Sovryn-smart-contracts.git
git pull --depth=1 origin master
### Get back to root folder ###
cd ..
### Relocated cloned folders ###
mv ./tmp/contracts ./contracts
mv ./tmp/interfaces ./interfaces
### Clean-ups ###
rm -rf tmp
rm -rf tmp_contracts
rm -rf tmp_interfaces