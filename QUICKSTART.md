# Quick Start Guide

Get up and running with Ralph Wiggum workflow for GitHub Copilot CLI in minutes.

## Prerequisites

1. **Install GitHub Copilot CLI**
   ```bash
   npm install -g @github/copilot
   ```

2. **Verify Installation**
   ```bash
   copilot --version
   ```

3. **Authenticate**
   ```bash
   copilot
   # Follow the authentication prompts
   ```

4. **Ensure you have a GitHub Copilot subscription**
   - Check at: https://github.com/settings/copilot

## 5-Minute Setup

### Step 1: Clone and Set Up (1 minute)

```bash
# Clone this repository
git clone https://github.com/RichardScottOZ/ralph-copilot.git
cd ralph-copilot

# Create a new project
./setup-ralph.sh my-todo-api
cd my-todo-api
```

### Step 2: Clarify Requirements (15-30 minutes)

```bash
# Start GitHub Copilot CLI
copilot
```

In Copilot, type or paste:
```
Read .copilot/instructions/clarify-phase.md and follow its instructions to interview me about my project. I want to build a simple REST API for managing todo items.
```

Answer the questions Copilot asks (aim for 40-70 questions covering all aspects).

The session will be saved to `clarify-session.md`.

### Step 3: Generate Execution Plan (5 minutes)

```bash
# Start GitHub Copilot CLI again
copilot
```

In Copilot, type:
```
Read .copilot/instructions/plan-phase.md and follow it to generate PROMPT.md and TODO.md from my clarify-session.md
```

This generates:
- `PROMPT.md` - Execution instructions
- `TODO.md` - Prioritized task list

### Step 4: Review and Adjust (5 minutes)

```bash
# Review the generated files
cat PROMPT.md
cat TODO.md

# Adjust if needed
nano PROMPT.md  # or your preferred editor
nano TODO.md
```

### Step 5: Execute! (Variable time)

```bash
# Run the Ralph loop with safety limits
./ralph-execute.sh --max-iterations 30
```

The loop will:
1. Read PROMPT.md
2. Pick next task from TODO.md
3. Implement it
4. Test it
5. Mark it done
6. Commit
7. Repeat until DONE

## What to Expect

### During Clarify Phase
- Expect 40-70 questions
- Takes 15-30 minutes
- Covers 8 categories comprehensively
- Results in detailed `clarify-session.md`

### During Plan Phase
- Takes ~5 minutes
- Generates focused PROMPT.md (~200 words)
- Generates prioritized TODO.md (15-40 tasks)
- Ready for execution

### During Execute Phase
- Each iteration: 30 seconds - 5 minutes
- Progress tracked in TODO.md
- Changes committed automatically
- Stops when all tasks complete or max iterations reached

## Monitoring Progress

```bash
# Check TODO.md for completed tasks
cat TODO.md

# View git commits
git log --oneline

# Check execution log
tail -f ralph-execution.log
```

## Stopping and Resuming

### To Stop
Press `Ctrl+C` in the terminal

### To Resume
```bash
# Review where you left off
cat TODO.md
git log --oneline -5

# Adjust PROMPT.md if needed
nano PROMPT.md

# Resume execution
./ralph-execute.sh --max-iterations 20
```

## Troubleshooting

### "copilot: command not found"
```bash
npm install -g @github/copilot
```

### "Authentication required"
```bash
copilot
# Follow prompts to authenticate
```

### "Loop runs forever"
- Check that PROMPT.md tells Copilot to output "DONE"
- Review TODO.md for unrealistic tasks
- Use `--max-iterations` flag to limit loops

### "Tasks not being completed"
- Make TODO.md tasks more specific
- Add more guardrails to PROMPT.md
- Break down complex tasks into smaller steps

## Tips for Success

1. **Be thorough in the Clarify phase** - More detail = better results
2. **Review generated files** - Adjust PROMPT.md and TODO.md before executing
3. **Start with low iterations** - Use `--max-iterations 10` first to test
4. **Monitor progress** - Check TODO.md and git log frequently
5. **Add guardrails gradually** - If Ralph fails, add specific "signs" to PROMPT.md

## Example: Full Workflow

```bash
# 1. Setup
./setup-ralph.sh weather-api
cd weather-api

# 2. Clarify (interactive)
copilot
# Paste: Read .copilot/instructions/clarify-phase.md and interview me
# Answer ~50 questions about weather API

# 3. Plan (interactive)
copilot
# Paste: Read .copilot/instructions/plan-phase.md and generate files

# 4. Review
cat PROMPT.md TODO.md
# Make any adjustments

# 5. Execute
./ralph-execute.sh --max-iterations 25

# 6. Done! Check results
git log --oneline
npm test  # or whatever your test command is
```

## Next Steps

- See [README.md](README.md) for full documentation
- Check [examples/](examples/) for sample projects
- Review PROMPT.md and TODO.md templates in [templates/](templates/)

## Getting Help

- GitHub Issues: https://github.com/RichardScottOZ/ralph-copilot/issues
- Original concept: https://ghuntley.com/ralph/
- GitHub Copilot CLI docs: https://docs.github.com/en/copilot/how-tos/use-copilot-agents/use-copilot-cli
