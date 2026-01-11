#!/bin/bash

# Ralph Wiggum Setup Script for GitHub Copilot CLI
# This script sets up a new project with the Ralph Wiggum workflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check for help flag
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Ralph Wiggum Setup Script for GitHub Copilot CLI"
    echo ""
    echo "Usage: ./setup-ralph.sh <project-name>"
    echo ""
    echo "This script sets up a new project with the Ralph Wiggum workflow."
    echo ""
    echo "Example:"
    echo "  ./setup-ralph.sh my-awesome-project"
    echo ""
    echo "The script will:"
    echo "  - Create a new directory for your project"
    echo "  - Initialize a git repository"
    echo "  - Copy Copilot instruction files"
    echo "  - Copy template files (PROMPT.md, TODO.md, clarify-session.md)"
    echo "  - Copy the execution script"
    echo "  - Create a project README"
    echo "  - Make an initial git commit"
    exit 0
fi

# Check if project name is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Project name required${NC}"
    echo "Usage: ./setup-ralph.sh <project-name>"
    echo "Use --help for more information"
    exit 1
fi

PROJECT_NAME="$1"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}🤖 Setting up Ralph Wiggum workflow for: ${GREEN}$PROJECT_NAME${NC}"
echo ""

# Create project directory
if [ -d "$PROJECT_NAME" ]; then
    echo -e "${RED}Error: Directory '$PROJECT_NAME' already exists${NC}"
    exit 1
fi

echo -e "${YELLOW}Creating project directory...${NC}"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize git
echo -e "${YELLOW}Initializing git repository...${NC}"
git init

# Create directory structure
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p .copilot/instructions
mkdir -p src

# Copy instruction files
echo -e "${YELLOW}Copying Copilot instruction files...${NC}"
if [ -d "$SCRIPT_DIR/.copilot/instructions" ]; then
    cp -r "$SCRIPT_DIR/.copilot/instructions/"* .copilot/instructions/
else
    echo -e "${RED}Warning: Instruction files not found at $SCRIPT_DIR/.copilot/instructions${NC}"
    echo -e "${YELLOW}You may need to copy them manually.${NC}"
fi

# Copy template files
echo -e "${YELLOW}Copying template files...${NC}"
if [ -d "$SCRIPT_DIR/templates" ]; then
    cp "$SCRIPT_DIR/templates/PROMPT.md" .
    cp "$SCRIPT_DIR/templates/TODO.md" .
    cp "$SCRIPT_DIR/templates/clarify-session.md" .
else
    echo -e "${RED}Warning: Templates not found at $SCRIPT_DIR/templates${NC}"
    echo -e "${YELLOW}Creating basic templates...${NC}"
    
    # Create basic PROMPT.md
    cat > PROMPT.md << 'EOF'
# PROMPT.md

## Project
[Describe your project]

## Instructions

1. Read TODO.md for current tasks
2. Pick the highest priority incomplete task
3. Implement it completely
4. Mark it done in TODO.md
5. Commit your changes
6. Continue to next task

When all tasks are complete, output: DONE
EOF

    # Create basic TODO.md
    cat > TODO.md << 'EOF'
# TODO

## Tasks
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

---
## Completed
EOF

    # Create basic clarify-session.md
    cat > clarify-session.md << 'EOF'
# Discovery Session

## Requirements
- [Add your requirements here]

## Notes
- [Add notes from clarification]
EOF
fi

# Copy execution script
echo -e "${YELLOW}Copying execution script...${NC}"
if [ -f "$SCRIPT_DIR/ralph-execute.sh" ]; then
    cp "$SCRIPT_DIR/ralph-execute.sh" .
    chmod +x ralph-execute.sh
else
    echo -e "${YELLOW}Creating basic execution script...${NC}"
    cat > ralph-execute.sh << 'EOF'
#!/bin/bash
# Basic Ralph execution loop for GitHub Copilot CLI

MAX_ITERATIONS=${1:-50}
iteration=0

echo "Starting Ralph execution loop (max $MAX_ITERATIONS iterations)..."
echo "Press Ctrl+C to stop"
echo ""

while [ $iteration -lt $MAX_ITERATIONS ]; do
    iteration=$((iteration + 1))
    echo "=== Iteration $iteration/$MAX_ITERATIONS ==="
    
    output=$(cat PROMPT.md | copilot 2>&1)
    echo "$output"
    
    if echo "$output" | grep -q "DONE"; then
        echo ""
        echo "Task completed at iteration $iteration!"
        exit 0
    fi
    
    sleep 2
done

echo ""
echo "Max iterations reached ($MAX_ITERATIONS)"
exit 1
EOF
    chmod +x ralph-execute.sh
fi

# Create a basic README
echo -e "${YELLOW}Creating project README...${NC}"
cat > README.md << EOF
# $PROJECT_NAME

This project uses the Ralph Wiggum workflow for autonomous AI development with GitHub Copilot CLI.

## Setup

This project was initialized with the Ralph Wiggum workflow for GitHub Copilot CLI.

## Workflow

### Phase 1: Clarify
Gather requirements through comprehensive questioning:

\`\`\`bash
# Interactive mode
copilot
# Then: "Read .copilot/instructions/clarify-phase.md and follow it"

# Or pipe the instructions
cat .copilot/instructions/clarify-phase.md | copilot
\`\`\`

### Phase 2: Plan
Convert requirements into execution files:

\`\`\`bash
# Interactive mode
copilot
# Then: "Read .copilot/instructions/plan-phase.md and follow it"

# Or pipe the instructions
cat .copilot/instructions/plan-phase.md | copilot
\`\`\`

### Phase 3: Execute
Run the autonomous loop:

\`\`\`bash
# Using the provided script (recommended)
./ralph-execute.sh

# Or basic loop
while :; do 
  output=\$(cat PROMPT.md | copilot)
  echo "\$output"
  if echo "\$output" | grep -q "DONE"; then
    echo "Task completed!"
    break
  fi
done
\`\`\`

## Files

- \`PROMPT.md\` - Instructions for the execution phase (generated by plan)
- \`TODO.md\` - Task checklist (generated by plan)
- \`clarify-session.md\` - Requirements from clarification phase
- \`.copilot/instructions/\` - Phase instruction files
- \`ralph-execute.sh\` - Safe execution loop script

## Prerequisites

- GitHub Copilot CLI installed: \`npm install -g @github/copilot\`
- GitHub Copilot subscription (Pro, Pro+, Business, or Enterprise)
- Node.js v22+ and npm v10+

## Learn More

See the main Ralph Wiggum documentation at:
https://github.com/RichardScottOZ/ralph-copilot
EOF

# Create .gitignore
echo -e "${YELLOW}Creating .gitignore...${NC}"
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
venv/
.venv/
__pycache__/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Build outputs
dist/
build/
*.pyc
*.pyo

# Logs
*.log
logs/
ralph-execution.log

# Environment
.env
.env.local

# Temporary files
tmp/
temp/
EOF

# Initial git commit
echo -e "${YELLOW}Creating initial git commit...${NC}"
git add .
git commit -m "Initial setup with Ralph Wiggum workflow for GitHub Copilot CLI"

# Success message
echo ""
echo -e "${GREEN}✅ Project setup complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "  1. ${YELLOW}cd $PROJECT_NAME${NC}"
echo -e "  2. ${YELLOW}copilot${NC} - Then read .copilot/instructions/clarify-phase.md"
echo -e "  3. ${YELLOW}copilot${NC} - Then read .copilot/instructions/plan-phase.md"
echo -e "  4. ${YELLOW}./ralph-execute.sh${NC} - Run the execution loop"
echo ""
echo -e "${BLUE}Project structure:${NC}"
if command -v tree &> /dev/null; then
    tree -L 2 "$PROJECT_NAME"
else
    echo "$PROJECT_NAME/"
    ls -1 "$PROJECT_NAME" | sed 's/^/  /'
fi
echo ""
echo -e "${GREEN}Happy coding with Ralph! 🤖${NC}"
