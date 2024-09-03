# Use a base image with a web server, such as nginx
FROM nginx:alpine

# Copy your webpage files to the appropriate directory in the container
COPY . /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]