#======= Build ========

FROM python:3.14-slim AS builder

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir mkdocs mkdocs-material
RUN mkdocs build

#======= Serve ========

FROM nginx:alpine

COPY --from=builder /app/site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
