# Use official Node.js LTS image as base
FROM node:20-alpine

# Create and set working directory
WORKDIR /app

# Install system dependencies and add npm dependencies
RUN apk add --no-cache \
    git \
    python3 \
    make \
    g++

# Copy package files first for better caching
COPY package*.json ./

# Clear npm cache and install dependencies
RUN npm cache clean --force && \
    npm install -g npm@latest && \
    npm ci --verbose

# Copy the rest of the application code
COPY . .

# Build the application if needed (uncomment if you have a build script)
# RUN npm run build

# Expose the port the app runs on
EXPOSE 8080

# Use non-root user for security
USER node

# Set environment to production
ENV NODE_ENV=production

# Command to run the application
CMD ["node", "server.js"]
