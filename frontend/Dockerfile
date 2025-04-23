FROM node:16 AS builder
## Stage 1: Build the frontend

CMD mkdir /app

## Set the working directory
WORKDIR /app

## Copy the package specifications
COPY package*.json webpack*.js ./

## Install all relevant dependencies
RUN npm install

## Copy all the relevant files + source code
COPY static ./static

## Carry out the build
RUN npm run build


## Second stage, use nginx to serve files that have been built
## alpine is a small footprint linux image
FROM nginx:1.27
COPY --from=builder /app/static/index.html /usr/share/nginx/html/
COPY --from=builder /app/static/build/* /usr/share/nginx/html/
COPY --from=builder /app/static/icons /usr/share/nginx/html/icons
COPY --from=builder /app/static/styles /usr/share/nginx/html/styles

COPY default.conf /etc/nginx/default.conf
