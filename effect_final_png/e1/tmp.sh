#!/bin/bash

for X in {0..10}
do
  # convert e1_${X}.png e1_${X}.xpm
  convert e1_${X}.png -transparent "#38B764" e1_${X}_back.png
  convert e1_${X}_back.png -fill "#73EFF7" -opaque "#A7F070" e1_${X}_back.png
  convert e1_${X}_back.png -fill "#73EFF7" -opaque "#94B0C2" e1_${X}_back.png
done
