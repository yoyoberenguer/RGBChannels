# RGBChannels
Convert image to a different format e.g RGB to BGR, RGB to GRB etc 

e.g 
swap_channels(surface, 'G0B')  -> swap G and R, Null green, B unchanged
swap_channels(surface, 'BGR')  -> Convert RGB to BGR
swap_channels(surface, '0G0')  -> extract Green channel

```
@cython.boundscheck(False)
@cython.wraparound(False)
@cython.nonecheck(False)
@cython.cdivision(True)
cdef swap_channels_c(surface_:Surface, model):
    """
    Swap/order image RGB channels in a given sequence.

    e.g
    Swaping the Red channel with Green
    Entire Green channel is 0
    Blue channel is untouched 
    swap_channels(surface, 'G0B')

    e.g
    Convert surface to BGR format
    swap_channels(surface, 'BGR')
    
    

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
        for i in prange(width, schedule=SCHEDULE, num_threads=THREAD_NUMBER):
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

```
