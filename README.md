# Tor Hidden Web Server

## Overview
This project sets up an **Nginx web server** accessible on the **Tor network** with SSH access on port **4242**. The static webpage is served through a `.onion` address.

## Features
- **Static Webpage** served via Nginx
- **Tor Network Integration** (Hidden service with `.onion` URL)
- **SSH Access on Port 4242**
- **Dockerized Deployment** (Optional for easier setup)

## Installation & Setup
### Prerequisites
- **Docker & Docker Compose** installed
- **Tor Browser** to access the `.onion` site

### Build & Run the Server
Run the following command to start the server:
```sh
make
```
This will:
- Build the Docker container
- Configure Nginx, Tor, and SSH
- Start the web server

To stop the server:
```sh
make down
```
To clean up everything:
```sh
make clean
```

## Accessing the Hidden Website
1. **Find your .onion address**:
   ```sh
   cat /var/lib/tor/hidden_service/hostname
   ```
   Copy the displayed `.onion` URL.

2. **Open in Tor Browser**:
   - Paste the `.onion` URL into Tor Browser and visit the site.

## SSH Access
To connect via SSH:
```sh
ssh -p 4242 user@<server-ip>
```
