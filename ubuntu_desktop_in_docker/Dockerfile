# Use the official Ubuntu base image
FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install Ubuntu Desktop and VNC server
RUN apt-get update && apt-get install -y \
    ubuntu-desktop \
    tigervnc-standalone-server \
    tigervnc-common \
    novnc \
    websockify \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up a password for VNC (replace 'password' with something secure)
RUN mkdir -p ~/.vnc && echo "password" | vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd

# Expose VNC (5901) and noVNC (6080) ports
EXPOSE 5901 6080

# Start the VNC server on container launch
CMD ["vncserver", "-fg", "-localhost", "no", ":1"]
