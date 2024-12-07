# Use the Node.js 20 base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Set environment variables
ENV PORT=8080

# Expose the application port
EXPOSE 8080

# Use nodemon to watch for changes and restart the app
CMD ["nodemon", "--watch", "src", "--exec", "tsc && node dist/index.js"]
