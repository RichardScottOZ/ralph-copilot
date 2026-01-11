# Project Summary: Ralph Copilot

## Overview

This repository provides an adaptation of the Ralph Wiggum autonomous development workflow from Kiro CLI to GitHub Copilot CLI. The Ralph Wiggum technique, created by Geoffrey Huntley, uses an iterative loop to autonomously develop software by repeatedly feeding instructions to an AI agent.

## Original Concept

The Ralph Wiggum technique is based on a simple yet powerful idea:

```bash
while :; do cat PROMPT.md | ai-tool; done
```

This loop feeds the same prompt repeatedly to an AI agent, which:
1. Reads the instructions
2. Checks what's done (via git and TODO.md)
3. Picks the next task
4. Implements it
5. Tests it
6. Commits it
7. Repeats

The technique is "deterministically bad in an undeterministic world" - when failures occur, you improve the prompts with better guardrails ("signs") rather than blame the tools.

## Adaptation from Kiro CLI to GitHub Copilot CLI

### Source: ralph-kiro
- Repository: https://github.com/RichardScottOZ/ralph-kiro
- Original tool: Kiro CLI with YAML agent configurations
- Structure: `.kiro/agents/*.yaml` files define agent behavior

### This Adaptation: ralph-copilot
- Repository: https://github.com/RichardScottOZ/ralph-copilot
- Target tool: GitHub Copilot CLI
- Structure: `.copilot/instructions/*.md` files provide natural language instructions

### Key Differences

| Aspect | Kiro CLI (ralph-kiro) | GitHub Copilot CLI (this repo) |
|--------|----------------------|--------------------------------|
| **Configuration Format** | YAML agent files | Markdown instruction files |
| **Agent System** | Named agents with tools | Natural language prompts |
| **Invocation** | `kiro-cli chat --agent ralph-clarify` | `cat .copilot/instructions/clarify-phase.md \| copilot` |
| **Mode System** | `--mode script` for non-interactive | Standard stdin piping |
| **Context Awareness** | Explicit file operations config | Built-in repository awareness |

### What Remained the Same

- The 3-phase workflow: Clarify → Plan → Execute
- The Ralph philosophy of iterative improvement
- Bash loop structure for execution
- Completion detection via "DONE" keyword
- Template structure for PROMPT.md and TODO.md
- Guardrail ("signs") approach to handling failures

## Repository Structure

```
ralph-copilot/
├── .copilot/
│   └── instructions/
│       ├── clarify-phase.md     # Requirements discovery instructions
│       ├── plan-phase.md        # Planning phase instructions
│       └── execute-phase.md     # Execution reference (loop uses PROMPT.md)
├── examples/
│   ├── todo-api-clarify-session.md     # Example clarify output
│   └── todo-api-execution-files.md     # Example PROMPT.md and TODO.md
├── templates/
│   ├── PROMPT.md                # Template for execution instructions
│   ├── TODO.md                  # Template for task checklist
│   └── clarify-session.md       # Template for requirements capture
├── README.md                    # Comprehensive documentation
├── QUICKSTART.md                # Quick start guide
├── CONTRIBUTING.md              # Contribution guidelines
├── LICENSE                      # MIT License
├── setup-ralph.sh               # Project setup script
└── ralph-execute.sh             # Execution loop script
```

## The Three Phases

### Phase 1: Clarify
**Purpose**: Exhaustive requirements discovery  
**Method**: Interactive questioning session  
**Output**: `clarify-session.md` with comprehensive requirements  
**Typical Duration**: 15-30 minutes, 40-70 questions

### Phase 2: Plan
**Purpose**: Convert requirements to actionable tasks  
**Method**: Read clarify session and generate execution files  
**Output**: 
- `PROMPT.md` - Instructions with guardrails
- `TODO.md` - Prioritized task checklist

**Typical Duration**: 5 minutes

### Phase 3: Execute
**Purpose**: Autonomous implementation  
**Method**: Bash loop feeding PROMPT.md to Copilot  
**Duration**: Variable (minutes to hours)  
**Behavior**: Iterates until all tasks complete or max iterations reached

## Usage Flow

```bash
# 1. Setup
./setup-ralph.sh my-project
cd my-project

# 2. Clarify (interactive with Copilot)
copilot
> Read .copilot/instructions/clarify-phase.md and interview me

# 3. Plan (interactive with Copilot)
copilot
> Read .copilot/instructions/plan-phase.md and generate files

# 4. Execute (autonomous loop)
./ralph-execute.sh --max-iterations 30
```

## Key Features

### For Users
- **Autonomous Development**: Set it up and let it run
- **Safety Limits**: Max iteration controls prevent runaway loops
- **Progress Tracking**: TODO.md and git commits show progress
- **Resumable**: Stop and resume at any time
- **Tunable**: Improve results by refining PROMPT.md

### For Developers
- **Simple Setup**: One script creates complete project structure
- **Clear Templates**: Examples guide proper usage
- **Comprehensive Docs**: README, QUICKSTART, and CONTRIBUTING guides
- **Tested Scripts**: All functionality verified
- **MIT Licensed**: Free to use and modify

## Technical Implementation

### setup-ralph.sh
Creates a new project with:
- Git repository initialization
- Directory structure (.copilot/instructions/, src/)
- Instruction files for each phase
- Template files
- Execution script
- README with workflow documentation
- Proper .gitignore

### ralph-execute.sh
Provides safe execution with:
- Configurable max iterations
- Custom completion word detection
- Execution logging
- Progress display
- Stuck detection
- Graceful interruption
- Time tracking

### Instruction Files
Markdown files that tell Copilot CLI:
- What role to take (clarify agent, plan agent, etc.)
- What process to follow
- What output to create
- What guardrails to observe
- When to stop

## Philosophy

Ralph Wiggum works because:
1. **Iteration beats perfection**: Many small steps reach the goal
2. **Prompts are programs**: Well-written instructions produce consistent results
3. **Failures are data**: Each failure teaches what guardrail to add
4. **Autonomy enables scale**: Set it and let it work
5. **Trust the process**: Eventually, it completes

## When to Use Ralph

✅ **Good for:**
- Greenfield projects with clear requirements
- Large refactoring efforts
- Test-driven development
- Repetitive implementation work
- Learning a new codebase structure

❌ **Not ideal for:**
- Exploratory research tasks
- Complex debugging without clear reproduction
- High-stakes production changes without review
- Tasks requiring frequent human judgment calls

## Success Factors

1. **Thorough Clarification**: 40-70 questions yield complete requirements
2. **Specific Tasks**: "Add JWT auth to /api routes" beats "Add security"
3. **Good Guardrails**: Learn from failures and add "signs" to PROMPT.md
4. **Reasonable Scope**: Start small, prove it works, then expand
5. **Monitoring**: Check TODO.md and git log regularly

## Credits and Attribution

- **Original Concept**: Geoffrey Huntley (https://ghuntley.com/ralph/)
- **Kiro CLI Adaptation**: RichardScottOZ (https://github.com/RichardScottOZ/ralph-kiro)
- **Copilot CLI Adaptation**: This repository

## License

MIT License - See LICENSE file

Based on the original Ralph Wiggum workflow by Geoffrey Huntley, adapted from ralph-kiro by RichardScottOZ.

## Contributing

See CONTRIBUTING.md for guidelines on:
- Reporting issues
- Suggesting enhancements
- Contributing code
- Improving documentation
- Testing changes

## Resources

- **This Repo**: https://github.com/RichardScottOZ/ralph-copilot
- **Original Ralph**: https://ghuntley.com/ralph/
- **ralph-kiro**: https://github.com/RichardScottOZ/ralph-kiro
- **Copilot CLI Docs**: https://docs.github.com/en/copilot/how-tos/use-copilot-agents/use-copilot-cli
- **Copilot CLI Getting Started**: https://github.blog/ai-and-ml/github-copilot/github-copilot-cli-how-to-get-started/
