#!/bin/bash

# Driver Dashboard - Quick Setup Script for Unix/Linux/macOS
# This script sets up and starts the Driver Dashboard server

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║   Driver Dashboard - PayMongo Integration             ║"
echo "║            Quick Setup Script                         ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed"
    echo "Please download from: https://nodejs.org/"
    exit 1
fi

echo "✓ Node.js found:"
node --version

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not found"
    exit 1
fi

echo "✓ npm found:"
npm --version
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating template..."
    cat > .env << EOF
# Server Configuration
PORT=5000
NODE_ENV=development

# PayMongo Configuration
PAYMONGO_SECRET=sk_test_YOUR_PAYMONGO_SECRET_KEY_HERE
EOF
    echo "✓ Created .env file"
    echo ""
    echo "⚠️  Please update .env with your PayMongo secret key:"
    echo "   https://dashboard.paymongo.com/developers"
    echo ""
fi

# Install dependencies
echo "Installing dependencies..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo ""
echo "✓ Setup complete!"
echo ""
echo "Starting server..."
echo ""

# Start the server
npm start
