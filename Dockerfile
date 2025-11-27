FROM debian:bookworm-slim

WORKDIR /app

# unzip tool
RUN apt-get update && apt-get install -y unzip

# copy the PocketBase zipped binary
COPY pocketbase.zip .

# unzip it
RUN unzip pocketbase.zip

# expose PocketBase port
EXPOSE 8090

# start PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
