#!/bin/bash

echo "Starting local web server..."
echo "App will be available at: http://localhost:8000"
echo "Press Ctrl+C to stop the server"
echo ""

# Start Python HTTP server
python3 -m http.server 8000
