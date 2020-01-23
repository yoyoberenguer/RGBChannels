###cython: boundscheck=False, wraparound=False, nonecheck=False, optimize.use_switch=True


# NUMPY IS REQUIRED
try:
    import numpy
    from numpy import ndarray, zeros, empty, uint8, int32, float64, float32, dstack, full, ones,\
    asarray, ascontiguousarray
except ImportError:
    print("\n<numpy> library is missing on your system."
          "\nTry: \n   C:\\pip install numpy on a window command prompt.")
    raise SystemExit

# CYTHON IS REQUIRED
try:
    cimport cython
    from cython.parallel cimport prange
except ImportError:
    print("\n<cython> library is missing on your system."
          "\nTry: \n   C:\\pip install cython on a window command prompt.")
    raise SystemExit

cimport numpy as np


# PYGAME IS REQUIRED
try:
    import pygame
    from pygame import Color, Surface, SRCALPHA, RLEACCEL, BufferProxy
    from pygame.surfarray import pixels3d, array_alpha, pixels_alpha, array3d
    from pygame.image import frombuffer

except ImportError:
    print("\n<Pygame> library is missing on your system."
          "\nTry: \n   C:\\pip install pygame on a window command prompt.")
    raise SystemExit

import random
from random import randint
import math

from libc.math cimport sin, sqrt, cos, atan2, pi, round, floor, fmax, fmin, pi, tan, exp, ceil, fmod
from libc.stdio cimport printf
from libc.stdlib cimport srand, rand, RAND_MAX, qsort, malloc, free, abs

__author__ = "Yoann Berenguer"
__credits__ = ["Yoann Berenguer"]
__version__ = "1.0.0 untested"
__maintainer__ = "Yoann Berenguer"
__email__ = "yoyoberenguer@hotmail.com"

# --------------------------- INTERFACE -----------------------------

cpdef swap_channels(surface_:Surface, model):
    return swap_channels_c(surface_, model)


@cython.boundscheck(False)
@cython.wraparound(False)
@cython.nonecheck(False)
@cython.cdivision(True)
cdef swap_channels_c(surface_:Surface, model):
    """
    :param surface_: pygame.Surface
    :param model: python string; String representing the channel order e.g
    RGB, RBG, GRB, GBR, BRG, BGR etc. letters can also be replaced by the digit 0
    to null the entire channel. e.g : 'R0B' -> no green channel  
        
    """
    assert isinstance(surface_, Surface), \
           'Expecting Surface for argument surface_ got %s ' % type(surface_)

    if len(model) != 3:
        print("\nArgument model is invalid.")
        raise ValueError("Choose between RGB, RBG, GRB, GBR, BRG, BGR")

    rr, gg, bb = list(model)
    order = {'R' : 0, 'G' : 1, 'B' : 2, '0': -1}

    cdef int width, height
    width, height = surface_.get_size()

    try:
        rgb_ = pixels3d(surface_)
    except (pygame.error, ValueError):
        try:
            rgb_ = array3d(surface_)
        except(pygame.error, ValueError):
            raise ValueError('\nIncompatible pixel format.')

    cdef:
        unsigned char [:, :, :] rgb_array = rgb_
        unsigned char [:, :, ::1] new_array = empty((height, width, 3), dtype=uint8)
        int i=0, j=0
        short int ri, gi, bi
    ri = order[rr]
    gi = order[gg]
    bi = order[bb]

    with nogil:
        for i in prange(width):
            for j in range(height):
                if ri == -1:
                    new_array[j, i, 0] = 0
                else:
                    new_array[j, i, 0] = rgb_array[i, j, ri]
                    
                if gi == -1:
                    new_array[j, i, 1] = 0                  
                else:
                    new_array[j, i, 1] = rgb_array[i, j, gi]
                    
                if bi == -1:
                    new_array[j, i, 2] = 0                
                else:
                    new_array[j, i, 2] = rgb_array[i, j, bi]

    return pygame.image.frombuffer(new_array, (width, height), 'RGB')


