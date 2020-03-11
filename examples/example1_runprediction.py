# -*- coding: utf-8 -*-
"""
CDeep3M-Colab

Author: M Haberl 2020
"""

##################
# Get Data
##################

# %cd /home/
!mkdir /home/6283
# %cd /home/6283/
!wget https://iruka.crbs.ucsd.edu/cdeep3m_results/6283/original/6283.tar
!tar -xvf 6283.tar
!rm /home/6283/6283.tar
!ls /home/6283/

!wget https://doi.org/10.7295/W9CDEEP3M50687
!mkdir /home/trainedmodel/
!tar -xvf W9CDEEP3M50687 -C /home/trainedmodel/
!ls /home/trainedmodel/

import os

d = '/home/trainedmodel/'
model_path = [os.path.join(d, o) for o in os.listdir(d) 
                    if os.path.isdir(os.path.join(d,o))]
model_path

!rm /home/6283/W9CDEEP3M50687
!ls /home/6283/
!rm -r /home/test_out

!/home/cdeep3m/runprediction.sh --augspeed 10 --models 3fm /home/trainedmodel/membranes_SBEMTEM_denoised_lastmodel /home/6283/ /home/test_out/
!ls /home/test_out
