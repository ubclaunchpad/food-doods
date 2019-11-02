# Using Node.js LTS
FROM node:10.16.3-alpine

# Specify a working directory
WORKDIR /usr/app/src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install npm packages
RUN npm install

EXPOSE 9000

# Run the server
CMD ["bin/sh", "npm", "run", "start:docker"]
