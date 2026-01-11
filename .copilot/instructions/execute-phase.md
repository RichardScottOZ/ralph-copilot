# Ralph Execute Phase Instructions for GitHub Copilot CLI

This file is for reference only. The actual execution instructions are in PROMPT.md, which is generated during the plan phase.

## How Execution Works

The execution phase uses a bash loop that repeatedly feeds PROMPT.md to GitHub Copilot CLI:

```bash
while :; do cat PROMPT.md | copilot; done
```

Or use the provided script with safety features:

```bash
./ralph-execute.sh --max-iterations 50
```

## What Happens in Each Iteration

1. Copilot reads PROMPT.md (which contains instructions)
2. Copilot reads TODO.md to see current tasks
3. Copilot picks the highest priority incomplete task
4. Copilot implements the task
5. Copilot runs tests/validation
6. Copilot marks task complete in TODO.md
7. Copilot commits changes
8. Loop repeats

## Completion

The loop exits when Copilot outputs "DONE" (as instructed in PROMPT.md), which happens when all tasks are complete and tests pass.

## Monitoring Progress

- Check TODO.md to see completed tasks
- Use `git log` to see commits
- Review the ralph-execution.log file (if using ralph-execute.sh)

## If Something Goes Wrong

**Loop runs forever:**
- Check that PROMPT.md instructs Copilot to output "DONE" when complete
- Verify tasks in TODO.md are achievable
- Consider adding more guardrails to PROMPT.md

**Copilot gets stuck:**
- If Copilot outputs "STUCK", it means the same issue failed 3 times
- Review the output to understand the issue
- Fix manually or adjust PROMPT.md/TODO.md
- Resume execution

**Copilot doesn't follow instructions:**
- Make PROMPT.md more specific and clear
- Add explicit guardrails for observed problems
- Break down complex tasks in TODO.md into smaller steps

## Safety Features

When using ralph-execute.sh:
- Max iteration limit (default 50)
- Execution log saved to file
- Progress display with iteration counter
- Detection of "STUCK" status
- Graceful interruption with Ctrl+C

## Manual Control

You can always stop the loop (Ctrl+C) and:
- Review TODO.md and git log
- Adjust PROMPT.md or TODO.md
- Resume execution

---

**To start execution, make sure PROMPT.md and TODO.md exist, then run:**

```bash
./ralph-execute.sh
```

Or manually:

```bash
while :; do 
  output=$(cat PROMPT.md | copilot)
  echo "$output"
  if echo "$output" | grep -q "DONE"; then
    echo "Task completed!"
    break
  fi
done
```
