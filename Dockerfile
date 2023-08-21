# build environment
FROM node:18.16.0 as build
WORKDIR /app
# ENV PATH /app/node_modules/.bin:$PATH
COPY . .
RUN npm ci
COPY . ./
RUN npm run
# production environment
FROM nginx:stable-alpine
COPY --from=build /app/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
