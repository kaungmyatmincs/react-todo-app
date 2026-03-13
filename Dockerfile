FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

# Add this line to install build dependencies for sqlite3
RUN apk add --no-cache python3 make g++ 

# Now run the install
RUN npm install --only=production

COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]