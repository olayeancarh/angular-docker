# Stage 1: Build application
# Specify a base image
FROM node:20-alpine as builder

# Work directory
WORKDIR /app

# Install some dependencies
COPY package.json .
RUN npm install -g @angular/cli
RUN npm install
COPY . .

# Build 
RUN npm run build --prod

# Stage 2: Deploy stage
FROM nginx
COPY --from=builder /app/dist/frontend/browser /usr/share/nginx/html
