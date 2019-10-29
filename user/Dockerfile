# Using Node.js LTS
FROM node:10.16.3-alpine

# Specify a working directory
WORKDIR /usr/app/src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install npm packages
RUN npm install

# Copy the remaining code (see .dockerignore if something is not showing up)
ADD . /usr/app/src

# Compile the server code
RUN npm run build

EXPOSE 8000

# Run the server
CMD ["npm", "run", "start"]
