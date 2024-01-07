FROM node:21.5.0-bullseye AS build
# Copy entire git repo (except .dockerignore'd files) into workspace
COPY . /app
WORKDIR /app

# Download dependencies
RUN yarn install --frozen-lockfile

# Run tests
RUN yarn test

# Build app
RUN yarn build

FROM nginx:1.23.1-alpine AS nginx
# Copy build output to nginx webroot
COPY --from=build /app/build /usr/share/nginx/html