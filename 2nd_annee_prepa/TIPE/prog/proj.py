import numpy as np
import pygame
from PIL import Image
from scipy.interpolate import RegularGridInterpolator

def pseudo_sphere(u, v):
    """ Génère les coordonnées de la pseudo-sphère sans la partie inférieure """
    x = np.cos(u) / np.cosh(v)
    y = np.sin(u) / np.cosh(v)
    z = v - np.tanh(v)
    return x, y, z

def project_image_on_pseudo_sphere(image_path, u_res=1000, v_res=1000):
    """ Projette une image sur la pseudo-sphère avec une nouvelle projection optimisée """
    # Charger l'image et la faire pivoter de 90°
    img = Image.open(image_path).convert('RGB')
    img = img.rotate(-90, expand=True)  # Rotation de 90°
    img = img.resize((v_res, u_res))  # Réduction de la résolution pour un meilleur rendu
    img_data = np.array(img)
    
    # Créer la grille de la pseudo-sphère en supprimant la partie inférieure
    u = np.linspace(0, 2 * np.pi, u_res)
    v = np.linspace(0, 2, v_res)  # Suppression de la partie inférieure (v > 0)
    U, V = np.meshgrid(u, v, indexing='ij')
    X, Y, Z = pseudo_sphere(U, V)
    
    # Nouvelle projection de l'image
    u_norm = (U - U.min()) / (U.max() - U.min())
    v_norm = (np.cosh(V) - np.cosh(V).min()) / (np.cosh(V).max() - np.cosh(V).min())
    points = np.array([u_norm.flatten(), v_norm.flatten()]).T
    
    # Création de l'interpolateur d'image
    u_idx = np.linspace(0, 1, u_res)
    v_idx = np.linspace(0, 1, v_res)
    interpolator_r = RegularGridInterpolator((u_idx, v_idx), img_data[:, :, 0])
    interpolator_g = RegularGridInterpolator((u_idx, v_idx), img_data[:, :, 1])
    interpolator_b = RegularGridInterpolator((u_idx, v_idx), img_data[:, :, 2])
    
    colors = np.zeros((u_res * v_res, 3), dtype=np.uint8)
    colors[:, 0] = interpolator_r(points)
    colors[:, 1] = interpolator_g(points)
    colors[:, 2] = interpolator_b(points)
    colors = colors.reshape((u_res, v_res, 3))
    
    # Initialiser pygame
    pygame.init()
    screen = pygame.display.set_mode((600, 600))
    pygame.display.set_caption("Projection sur Pseudo-Sphère")
    clock = pygame.time.Clock()
    
    angle_x, angle_y = 0, 0
    
    # Affichage de la projection avec rotation optimisée
    running = True
    while running:
        screen.fill((0, 0, 0))
        rot_x = np.array([[1, 0, 0], [0, np.cos(angle_x), -np.sin(angle_x)], [0, np.sin(angle_x), np.cos(angle_x)]])
        rot_y = np.array([[np.cos(angle_y), 0, np.sin(angle_y)], [0, 1, 0], [-np.sin(angle_y), 0, np.cos(angle_y)]])
        
        pixels = pygame.PixelArray(screen)
        for i in range(u_res):
            for j in range(v_res):
                vec = np.array([X[i, j], Y[i, j], Z[i, j]])
                vec = rot_x @ vec
                vec = rot_y @ vec
                x, y = int((vec[0] + 1) * 300), int((vec[1] + 1) * 300)
                if 0 <= x < 600 and 0 <= y < 600:
                    pixels[x, y] = tuple(colors[i, j])
        
        del pixels  # Libérer les pixels pour appliquer les modifications
        pygame.display.flip()
        
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    angle_y -= 0.1
                if event.key == pygame.K_RIGHT:
                    angle_y += 0.1
                if event.key == pygame.K_UP:
                    angle_x -= 0.1
                if event.key == pygame.K_DOWN:
                    angle_x += 0.1
        
        clock.tick(60)  # Augmentation du taux de rafraîchissement
    
    pygame.quit()

# Exemple d'utilisation
project_image_on_pseudo_sphere("/home/jvj/gith/typst-file/Typstfile/2nd_annee_prepa/TIPE/image/diffprojS/Equirectangular_projection_SW.jpg")
