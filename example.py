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
    im = swap_channels(asp, 'GRB')
    for r in range(30):
        pygame.event.pump()
        screen.blit(im, (0, 0))
        pygame.display.flip()
    pygame.image.save(im, "swap.png")
    im = swap_channels(asp, 'RG0')
    for r in range(30):
        pygame.event.pump()
        screen.blit(im, (0, 0))
        pygame.display.flip()
    pygame.image.save(im, "swap.png")
