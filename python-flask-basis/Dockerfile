# syntax=docker/dockerfile:1.2
FROM python:3.12.9-alpine3.21

# .pyc files not needed in containers and No buffer for logs.
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app

RUN addgroup --gid 10001 appgroup && \
    adduser -D --uid 10000 appuser appgroup && \
    chown appuser:appgroup -R /app && \
    chown appuser:appgroup -R /home/appuser
USER appuser

# Build the steps start with ONBUILD later when building the app.
ONBUILD COPY requirements.txt .

# Create a cache for libs to reduce building time if needed.
# Be aware of the consequences of caching python libs.

#ONBUILD RUN --mount=type=cache,target=/usr/local/lib/ \
#        pip install --no-cache-dir -r requirements.txt

ONBUILD RUN pip install --no-cache-dir -r requirements.txt

# In case of changes in this layer, no need to install libs again.
ONBUILD COPY . .

ONBUILD EXPOSE 5000

ONBUILD CMD ["python", "app.py"]

