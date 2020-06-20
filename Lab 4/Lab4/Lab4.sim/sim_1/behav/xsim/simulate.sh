#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Apr 16 10:19:49 +03 2020
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim top_tb_behav -key {Behavioral:sim_1:Functional:top_tb} -tclbatch top_tb.tcl -log simulate.log"
xsim top_tb_behav -key {Behavioral:sim_1:Functional:top_tb} -tclbatch top_tb.tcl -log simulate.log

