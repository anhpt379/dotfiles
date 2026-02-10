# Global Claude Rules

## Commit Messages

- Format for monorepo: `scope: title` (e.g., `nvim: unpin treesitter version`)
- Format for non-monorepo: `title` only
- Do not use conventional commit types (feat, fix, chore, etc.) unless it's
  being used recently for the repo
- Title: ~50 characters max
- Body: 72 characters per line, explain why the change is necessary and any side
  effects

## Code Style

- Python: Use `black` for formatting
