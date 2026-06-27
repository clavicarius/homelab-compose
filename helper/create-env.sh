#!/bin/bash
rm -f .env

FOUND=0
if [ -f "../.env.common.example" ]; then
  cat ../.env.common.example >> .env
  echo "" >> .env
  FOUND=1
fi

if [ -f ".env.example" ]; then
  cat .env.example >> .env
  echo "" >> .env
  FOUND=1
fi

if [ "$FOUND" -eq 0 ]; then
  echo "No environment file found."
  exit 1
fi

echo "Using environment:"
cat .env
