# Utilise l'image nginx officielle comme base
FROM nginx:alpine

# Supprime la page par défaut de nginx
RUN rm /usr/share/nginx/html/*

# Copie les fichiers du jeu dans le répertoire nginx
COPY index.html /usr/share/nginx/html/

# Crée un fichier de configuration nginx personnalisé
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
    # Configuration pour les fichiers statiques \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Expose le port 80
EXPOSE 80

# Démarre nginx
CMD ["nginx", "-g", "daemon off;"]