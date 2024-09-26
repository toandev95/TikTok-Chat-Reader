# Stage 1: Development
FROM node:20-slim AS development

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

RUN pnpm install
RUN pnpm fetch --prod

# Stage 2: Production
FROM node:20-alpine AS production

WORKDIR /app

COPY . .
COPY --from=development /app/node_modules ./node_modules

CMD ["node", "server"]