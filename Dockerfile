FROM node:16.20.2-bullseye AS build
# Copy entire git repo (except .dockerignore'd files) into workspace
COPY . /app
WORKDIR /app

# Download dependencies
RUN yarn install --frozen-lockfile

# Run tests
RUN yarn test

# Build app
RUN yarn build

FROM nginx:1.25.3-alpine AS nginx
# Copy build output to nginx webroot
COPY --from=build /app/build /usr/share/nginx/html