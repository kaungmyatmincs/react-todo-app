# Use a lightweight Node.js image based on Alpine Linux
FROM node:18-alpine

# Create and set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy the rest of the application source code
# Note: node_modules and .env should be excluded via .dockerignore
COPY . .

# The application runs on port 3000
EXPOSE 3000

# Start the application
CMD ["node", "src/index.js"]
