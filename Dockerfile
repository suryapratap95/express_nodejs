# Use official Node.js LTS image as base
FROM node:20-alpine

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Use non-root user for security
USER node

# Command to run the application
CMD ["node", "server.js"]