# Dockerfile

# Stage 1: Build FastAPI Backend
FROM nmbatingal/grind-sys-backend as grind-backend-build

# Stage 2: Build React Frontend
FROM nmbatingal/grind-sys-frontend as grind-frontend-build

# Stage 3: Build React User Portal
FROM nmbatingal/grind-user-frontend as grind-user-build

# Final Stage: Assemble the Image
FROM nginx:alpine

# Copy Nginx configuration file
COPY /nginx/nginx.conf /etc/nginx/nginx.conf

# Copy built frontend static files to nginx directory
COPY --from=grind-frontend-build /app/build /usr/share/nginx/html/frontend
COPY --from=grind-user-build /app/build /usr/share/nginx/html/user-frontend

# Expose ports
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
