FROM node:18-bullseye-slim

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN apt-get update && apt-get install -y \
    chromium \
    libnss3 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libxss1 \
    fonts-liberation \
    xvfb \
    apt-utils \
    --no-install-recommends

CMD ["node", "index.js"]
