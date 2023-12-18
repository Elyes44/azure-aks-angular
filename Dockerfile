### STAGE 1: Build Angular app ###
FROM node AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm cache clean --force
COPY . .
RUN npm install --legacy-peer-deps --force
RUN npm run build --prod

### STAGE 2: Run with Nginx ###
FROM nginx:latest AS ngi
COPY --from=build /app/dist/crudtuto-Front /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
