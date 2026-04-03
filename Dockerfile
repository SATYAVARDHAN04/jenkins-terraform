FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20-alpine
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodbcontainer:27017/catalogue" 
WORKDIR /app
COPY --from=builder /app/package.json /app/
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/server.js /app/
RUN chown -R roboshop:roboshop /app
USER roboshop
CMD [ "node","server.js" ]


# FROM node:20-alpine
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# RUN mkdir /app
# WORKDIR /app
# COPY package.json .
# COPY *.js .
# RUN npm install
# RUN chown -R roboshop:roboshop /app
# USER roboshop
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodbcontainer:27017/catalogue" 
# CMD ["node","server.js"]