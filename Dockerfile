# add the base image
FROM node:alpine

# Specify a working directory of app
WORKDIR '/app'

# Copy over my package.json
COPY package.json .

# Run npm install

RUN npm install

# Copy over all of the source code

COPY . .

RUN npm run build

# ------------------- START of the second phase ------------------------------
# a new from statement terminates the preceding block

FROM nginx
# THIS IS SPECIFIC for elastic beanstalk -- tells beanstalk which port to map traffic to
EXPOSE 80
# Copy something over from the other phase that I was working on
# Tell docker what you want to copy over to where
COPY --from=0 /app/build /usr/share/nginx/html