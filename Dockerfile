FROM alpine:3.18

# Install curl and ca-certificates
RUN apk add --no-cache ca-certificates curl

# Download pocketbase (change version if desired)
ENV PB_VER=0.19.0
RUN curl -sL -o /pocketbase.tar.gz "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VER}/pocketbase_${PB_VER}_linux_amd64.zip" \
    && apk add --no-cache unzip \
    && unzip /pocketbase.tar.gz -d / \
    && rm /pocketbase.tar.gz

EXPOSE 8090

# Use a data directory that will persist in Render's filesystem (ephemeral between deploys)
RUN mkdir -p /pb_data
VOLUME /pb_data

WORKDIR /
CMD ["/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data"]

