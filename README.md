# RGBChannels
Convert image to a different format e.g RGB to BGR, RGB to GRB etc 


![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/RGB.png)
![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/BGR.png) 

![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/GRB.png) 
![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/RG0.png) 


## Requirement 
```
Python >= 3.0
pygame >= 1.9.6
Cython 
Numpy
C compiler (MINGW32, gcc)
```

## Building project
```
After any changes in the pyx file do the following in a DOS prompt.
C:\>python setup_swap.py build_ext --inplace
```

## How to
```
e.g 
swap_channels(surface, 'G0B')  -> swap G and R, Null green, B unchanged
swap_channels(surface, 'BGR')  -> Convert RGB to BGR
swap_channels(surface, '0G0')  -> extract Green channel

Run the file example.py below from your python editor

import SWAP_CHANNELS
from SWAP_CHANNELS import swap_channels
import pygame

if __name__ == "__main__":
    asp = pygame.image.load("Aspens.jpg")
    im = swap_channels(asp, 'BGR')
    w, h = im.get_size()
    # im = pygame.transform.smoothscale(im, (800, 800))
    screen = pygame.display.set_mode((800, 800))
    for r in range(30):
        pygame.event.pump()
        screen.blit(im, (0, 0))
        pygame.display.flip()
       
    # Change the original image into a format GRB
    im = swap_channels(asp, 'GRB')   
    for r in range(30):
        pygame.event.pump()
        screen.blit(im, (0, 0))
        pygame.display.flip()
    
    # Change image to RG0 (no blue channel)
    im = swap_channels(asp, 'RG0')
    for r in range(30):
        pygame.event.pump()
        screen.blit(im, (0, 0))
        pygame.display.flip()
    pygame.image.save(im, "swap.png")


```

