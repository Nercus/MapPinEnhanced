#!/bin/bash


# clear libs folder but keep the _imports.xml file
find ./libs -mindepth 1 ! -name '_imports.xml' -exec rm -rf {} +

# Libstub
svn checkout https://repos.curseforge.com/wow/libstub/trunk ./libs/LibStub

# CallbackHandler
svn checkout https://repos.curseforge.com/wow/callbackhandler/trunk/CallbackHandler-1.0 ./libs/CallbackHandler-1.0

# LibDBIcon
svn checkout https://repos.curseforge.com/wow/libdbicon-1-0/trunk/LibDBIcon-1.0 ./libs/LibDBIcon-1.0

# HereBeDragons
git clone https://repos.wowace.com/wow/herebedragons ./libs/HereBeDragons

# LibDataBroker
git clone https://github.com/tekkub/libdatabroker-1-1 ./libs/LibDataBroker-1.1

# NercUtils
git clone https://github.com/Nercus/NercUtils ./libs/NercUtils

# Remove .git directories from cloned repositories
find ./libs -type d -name ".git" -exec rm -rf {} +
