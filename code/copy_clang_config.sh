#!/bin/bash

SOURCE_DIR="$HOME/dotfiles/code"

if [ -z "$1" ]; then
    echo "Usage: $0 <destination_directory>"
    exit 1
fi

DEST_DIR="$1"

if [ ! -d "$DEST_DIR" ]; then
    echo "Creating project directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
fi

cp "$SOURCE_DIR/.clang-tidy" "$DEST_DIR"
cp "$SOURCE_DIR/.clang-format" "$DEST_DIR"

# Initialize Git if not already a repo
if [ ! -d "$DEST_DIR/.git" ]; then
    cd "$DEST_DIR" || exit
    git init
    echo "✅ Git repository initialized in '$DEST_DIR'"
fi

echo "✅ .clang-tidy and .clang-format copied to '$DEST_DIR'"
