# Contributing to Ralph Copilot

Thank you for your interest in contributing to the Ralph Wiggum workflow for GitHub Copilot CLI!

## How to Contribute

### Reporting Issues

If you encounter a problem:

1. Check existing issues first
2. Create a new issue with:
   - Clear description of the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Your environment (OS, Node.js version, Copilot CLI version)

### Suggesting Enhancements

For feature requests:

1. Check if it already exists in issues
2. Describe the use case and why it's valuable
3. Provide examples if possible

### Code Contributions

#### Setup for Development

```bash
# Fork and clone the repository
git clone https://github.com/YOUR-USERNAME/ralph-copilot.git
cd ralph-copilot

# Create a branch for your changes
git checkout -b feature/your-feature-name
```

#### Guidelines

1. **Keep it simple** - Ralph is about simplicity and clarity
2. **Test your changes** - Try the workflow end-to-end
3. **Update documentation** - Keep README.md and other docs in sync
4. **Follow the philosophy** - Maintain the Ralph Wiggum approach

#### What to Contribute

Good contribution areas:

- **Instruction improvements** - Make phase instructions clearer
- **Script enhancements** - Improve setup or execution scripts
- **Examples** - Add more example clarify sessions and execution files
- **Documentation** - Improve clarity, add tutorials, fix typos
- **Templates** - Better PROMPT.md and TODO.md templates
- **Bug fixes** - Fix issues in scripts or documentation

#### Making a Pull Request

1. Make your changes
2. Test thoroughly:
   ```bash
   # Test the setup script
   ./setup-ralph.sh test-project
   cd test-project
   
   # Verify structure and files
   ls -R
   ```

3. Commit with clear messages:
   ```bash
   git add .
   git commit -m "Add clarification for authentication in clarify phase"
   ```

4. Push and create PR:
   ```bash
   git push origin feature/your-feature-name
   ```

5. In your PR description:
   - Explain what changed and why
   - Link to any related issues
   - Describe how you tested

## Code Style

- **Shell scripts**: Follow standard bash conventions
- **Markdown**: Use clear formatting, headers, and examples
- **Comments**: Explain why, not what

## Documentation Standards

- Keep README.md comprehensive but not overwhelming
- Use QUICKSTART.md for step-by-step guides
- Add examples to examples/ directory
- Keep templates/ minimal and adaptable

## Testing Your Changes

Before submitting:

1. Test the setup script creates proper structure
2. Verify instruction files are clear and actionable
3. Test execution script with both success and failure cases
4. Check all documentation renders correctly

Example test workflow:
```bash
# Create test project
./setup-ralph.sh test-todo-api
cd test-todo-api

# Verify files exist
test -f .copilot/instructions/clarify-phase.md && echo "✓ Clarify instructions"
test -f .copilot/instructions/plan-phase.md && echo "✓ Plan instructions"
test -f ralph-execute.sh && echo "✓ Execute script"
test -x ralph-execute.sh && echo "✓ Script is executable"

# Test execution script help
./ralph-execute.sh --help
```

## Improving Instructions

The `.copilot/instructions/*.md` files are critical. When improving them:

1. **Test with actual GitHub Copilot CLI** - Don't assume, verify
2. **Be specific** - Vague instructions lead to vague results
3. **Add examples** - Show what good looks like
4. **Include guardrails** - Help prevent common mistakes
5. **Structure clearly** - Use headers, lists, and sections

## Community

- Be respectful and constructive
- Help others learn the Ralph technique
- Share your success stories
- Report what works and what doesn't

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

- Open an issue for questions
- Reference original Ralph documentation: https://ghuntley.com/ralph/
- Check GitHub Copilot CLI docs: https://docs.github.com/en/copilot/how-tos/use-copilot-agents/use-copilot-cli

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes (for significant contributions)

Thank you for helping improve the Ralph Wiggum workflow! 🤖
