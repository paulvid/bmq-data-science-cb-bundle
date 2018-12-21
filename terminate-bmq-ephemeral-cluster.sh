#!/bin/bash

###############################
# 0. Initializing environment #
###############################

export PATH=$PATH:/Users/pvidal/Documents/Playground/cb-cli/

################################################
# 1. Get a list of clusters and terminate them #
################################################

cb cluster list | grep Name | awk -F \" '{print $4}' | while read cluster; do
  echo "Terminating ""$cluster""..."
  cb cluster delete --name $cluster
done 
