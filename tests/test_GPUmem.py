# -*- coding: utf-8 -*-
"""
CDeep3M-Colabs

Author: M Haberl 2020
"""

## Check Available GPU
import torch.cuda
t = round(torch.cuda.get_device_properties(0).total_memory * 10e-7)
c = torch.cuda.memory_cached(0)
a = torch.cuda.memory_allocated(0)
f = c-a  # free inside cache
print("Available GPU memory: " + str(t/1000) + " GB")
if t<11.5:
  print("Not enough GPU Memory\n Please go to Runtime -> Factory reset runtime")
