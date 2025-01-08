#!/bin/bash

# Check if httpd is running
if ps aux | grep -v grep | grep -q httpd; then
    echo "This machine is running a web server."
else
    echo "The httpd daemon is not running."
fi

# Check if init is running
if ps aux | grep -v grep | grep -q init; then
    echo "The init daemon is running."
else
    echo "The init daemon is not running."
fi