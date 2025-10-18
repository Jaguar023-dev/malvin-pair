# Use a modern Node base image (Debian 12 - Bookworm)
FROM node:22-bookworm

# Install required system packages
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package files first (for better caching)
COPY package*.json ./

# Install Node dependencies
RUN npm install && npm install -g qrcode-terminal pm2

# Copy remaining app files
COPY . .

# Expose port (use 5000 to match your app config)
EXPOSE 5000

# Start the app
CMD ["npm", "start"]