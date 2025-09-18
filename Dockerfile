FROM node:18-bullseye-slim

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN apt-get update && apt-get install -y \
    chromium \
    libnss3 \
    libnss3-dev \
    libgconf-2-4 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libxss1 \
    libx11-xcb1 \
    libxtst6 \
    libfontconfig1 \
    libappindicator1 \
    libxss1 \
    libdbus-glib-1-2 \
    libxdg-utils \
    libatspi2.0-0 \
    libdrm-dev \
    fonts-liberation \
    xvfb \
    apt-utils \
    --no-install-recommends

CMD ["node", "index.js"]
