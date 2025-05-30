# Claude Code Best Practices - TLDR

## Quick Setup

```bash
# Create project instructions
echo "# Project conventions and commands" > CLAUDE.md

# Configure allowed tools
claude code --allowedTools bash,edit,read,write

# Use headless mode for automation
claude code -p "fix all type errors" | tee fix.log
```

## Essential Workflows

### 1. Explore-Plan-Code-Commit
```bash
# Start with exploration (no code writing)
claude code -m explore "understand the auth system"

# Plan implementation
claude code -m think "plan OAuth integration"

# Execute and commit
claude code "implement OAuth2" --commit
```

### 2. Test-Driven Development
```bash
# Write tests first
claude code "write tests for user authentication"

# Implement to pass tests
claude code "implement auth to pass tests"
```

### 3. Visual Development
```bash
# Iterate on UI with screenshots
claude code "match this design" design.png
# Take screenshot → iterate → repeat
```

## Power User Tips

```bash
# Clear context for focused work
/clear

# Custom commands in .claude/commands
echo 'name: typecheck
description: Run type checking
command: npm run typecheck' > .claude/commands/typecheck.yml

# Parallel tasks with git worktrees
git worktree add ../feature-auth
cd ../feature-auth && claude code "implement auth"

# Multiple instances for different concerns
claude code "refactor database layer" &
claude code "update API docs" &
```

## CLAUDE.md Essentials

```markdown
# CLAUDE.md

## Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`
- Deploy: `./scripts/deploy.sh`

## Code Style
- Use 2 spaces for indentation
- Prefer async/await over promises
- No console.log in production code

## Repository Rules
- Never commit to main directly
- Run tests before committing
- Update docs with API changes
```

## Key Principles

1. **Be Specific**: "Fix the login bug where users can't reset passwords" > "fix bugs"
2. **Course-Correct Early**: Stop and redirect if going wrong direction
3. **Provide Targets**: Give tests, screenshots, or examples to match
4. **Document Commands**: Put frequently used commands in CLAUDE.md
5. **Manage Context**: Use /clear to maintain focus on current task

## MCP Servers for Extended Capabilities

```bash
# Install GitHub CLI for PR management
brew install gh

# Use MCP servers for additional tools
claude code --mcp-server @github/mcp-server-github
```