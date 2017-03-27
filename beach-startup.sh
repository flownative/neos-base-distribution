#!/bin/bash

/application/flow site:list |grep -q "No sites available" && /application/flow site:import Neos.Demo
