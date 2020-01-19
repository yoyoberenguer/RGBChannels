# RGBChannels
Convert image to a different format e.g RGB to BGR, RGB to GRB etc 

RGB 
![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/RGB.png)
BGR
![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/BGR.png) 

GRB
![alt text](https://github.com/yoyoberenguer/RGBChannels/blob/master/GRB.png) 
RG0
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

see example.py file for more precision
```

## Timings
```
image Aspen.jpg 1600x1200 24 bit depth
1000 iterations gives a total processing time of 15 secs (15ms each) (intel xeon 2.4Ghz)

```




