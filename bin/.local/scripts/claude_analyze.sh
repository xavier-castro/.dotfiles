#!/bin/bash

# Script to prepare a code project for Claude Desktop analysis
# Usage: ./claude_analyze.sh <project_directory>

if [ -z "$1" ]; then
  echo "Error: Please provide a project directory path"
  echo "Usage: ./claude_analyze.sh <project_directory>"
  exit 1
fi

PROJECT_DIR="$1"
OUTPUT_FILE="claude_analysis_$(date +%Y%m%d_%H%M%S).md"

# Check if the directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: Directory '$PROJECT_DIR' does not exist"
  exit 1
fi

echo "🔍 Analyzing project in '$PROJECT_DIR'..."

# Create the analysis file
ANALYSIS_FILE="project_for_claude_$(date +%Y%m%d_%H%M%S).md"

# Generate project overview
echo "# Code Project Analysis Request" > "$ANALYSIS_FILE"
echo "" >> "$ANALYSIS_FILE"
echo "## Project Structure" >> "$ANALYSIS_FILE"
echo '```' >> "$ANALYSIS_FILE"
find "$PROJECT_DIR" -type f -not -path "*/node_modules/*" -not -path "*/\.*" -not -path "*/venv/*" | sort >> "$ANALYSIS_FILE"
echo '```' >> "$ANALYSIS_FILE"

# Add file content analysis for important files
echo -e "\n## Key Files Content" >> "$ANALYSIS_FILE"

# Identify project type and key files
if [ -f "$PROJECT_DIR/package.json" ]; then
  echo "Detected JavaScript/TypeScript project" >> "$ANALYSIS_FILE"
  # Include package.json
  echo -e "\n### package.json" >> "$ANALYSIS_FILE"
  echo '```json' >> "$ANALYSIS_FILE"
  cat "$PROJECT_DIR/package.json" >> "$ANALYSIS_FILE"
  echo '```' >> "$ANALYSIS_FILE"
elif [ -f "$PROJECT_DIR/requirements.txt" ] || [ -f "$PROJECT_DIR/setup.py" ]; then
  echo "Detected Python project" >> "$ANALYSIS_FILE"
  # Include requirements or setup
  if [ -f "$PROJECT_DIR/requirements.txt" ]; then
    echo -e "\n### requirements.txt" >> "$ANALYSIS_FILE"
    echo '```' >> "$ANALYSIS_FILE"
    cat "$PROJECT_DIR/requirements.txt" >> "$ANALYSIS_FILE"
    echo '```' >> "$ANALYSIS_FILE"
  fi
elif [ -f "$PROJECT_DIR/go.mod" ]; then
  echo "Detected Go project" >> "$ANALYSIS_FILE"
  echo -e "\n### go.mod" >> "$ANALYSIS_FILE"
  echo '```' >> "$ANALYSIS_FILE"
  cat "$PROJECT_DIR/go.mod" >> "$ANALYSIS_FILE"
  echo '```' >> "$ANALYSIS_FILE"
fi

# Add other important files like README, etc.
if [ -f "$PROJECT_DIR/README.md" ]; then
  echo -e "\n### README.md" >> "$ANALYSIS_FILE"
  echo '```markdown' >> "$ANALYSIS_FILE"
  cat "$PROJECT_DIR/README.md" >> "$ANALYSIS_FILE"
  echo '```' >> "$ANALYSIS_FILE"
fi

# Analyze source code files (limited to prevent massive files)
echo -e "\n## Source Code Samples" >> "$ANALYSIS_FILE"

# Function to add file content with syntax highlighting
add_file_content() {
  local file="$1"
  local extension="${file##*.}"
  echo -e "\n### $(basename "$file")" >> "$ANALYSIS_FILE"
  echo '```'"$extension" >> "$ANALYSIS_FILE"
  cat "$file" >> "$ANALYSIS_FILE"
  echo '```' >> "$ANALYSIS_FILE"
}

# Get main source files (limited number to keep file manageable)
# Adjust these patterns for your project types
for pattern in "*.py" "*.js" "*.ts" "*.go" "*.java" "*.html" "*.css"; do
  # Find up to 3 files of each type, exclude test files and large files
  find "$PROJECT_DIR" -name "$pattern" -not -path "*/node_modules/*" -not -path "*/\.*" \
    -not -path "*/test/*" -not -path "*/tests/*" -size -50k | head -3 | while read file; do
    add_file_content "$file"
  done
done

# Add instructions for Claude
echo -e "\n## Analysis Request" >> "$ANALYSIS_FILE"
echo "Please provide a comprehensive analysis of this code project including:" >> "$ANALYSIS_FILE"
echo "1. Overview of what the project does based on the files and code" >> "$ANALYSIS_FILE"
echo "2. Code quality assessment" >> "$ANALYSIS_FILE"
echo "3. Potential bugs or security issues" >> "$ANALYSIS_FILE"
echo "4. Architecture recommendations" >> "$ANALYSIS_FILE"
echo "5. Suggestions for improvements" >> "$ANALYSIS_FILE"

# Finalize
echo -e "\n\nAnalysis file prepared: $ANALYSIS_FILE"
echo "Please follow these steps:"
echo "1. Open Claude Desktop"
echo "2. Open the file: $ANALYSIS_FILE"
echo "3. Copy its contents and paste into Claude"
echo "4. Save Claude's response to a file for your reference"

# Try to open the file with the default application
if command -v open &> /dev/null; then
  echo "Attempting to open the analysis file..."
  open "$ANALYSIS_FILE"
elif command -v xdg-open &> /dev/null; then
  echo "Attempting to open the analysis file..."
  xdg-open "$ANALYSIS_FILE"
fi

echo "✅ Done!"
