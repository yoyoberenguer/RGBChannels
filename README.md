# RGBChannels
Convert image to a different format e.g RGB to BGR, RGB to GRB etc 

## Requirement 
```
Python >= 3.0
Cython 
Numpy
C compiler (MINGW32, gcc)
```

## Building project
C:\>python setup_swap.py build_ext --inplace

```
e.g 
swap_channels(surface, 'G0B')  -> swap G and R, Null green, B unchanged
swap_channels(surface, 'BGR')  -> Convert RGB to BGR
swap_channels(surface, '0G0')  -> extract Green channel
```

