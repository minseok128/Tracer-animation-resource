#!/bin/bash

for X in {0..23}
do
  convert recall_${X}.xpm recall_${X}.png
done

