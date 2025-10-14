# Base image
FROM node:20-alpine3.19

# Update system packages to fix vulnerabilities
RUN apk update && apk upgrade

# Define variables
ARG APP_NAME

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Creates a "dist" folder with the production build
RUN npm run build -- ${APP_NAME}

# Start the server using the production build
CMD [ "node", "dist/apps/${APP_NAME}/main.js" ]