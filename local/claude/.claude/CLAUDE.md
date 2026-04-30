# Global Claude Rules

NEVER use Claude's built-in WebSearch tool. Instead, use the
`toolbox/web_search` MCP tool.
Example: `mcp-cli call toolbox/web_search '{"query": "your search query here"}'`

## Commit Messages

- Format for monorepo: `scope: title` (e.g., `nvim: unpin treesitter version`)
- Format for non-monorepo: `title` only
- Do not use conventional commit types (feat, fix, chore, etc.) unless it's
  being used recently for the repo
- Title: ~50 characters max
- Body: 72 characters per line, written in narrative flow:
  1. Context: what the current setup does
  2. Problem: why it works but is fragile, or what's wrong
  3. Solution: what the new setup does and why it's better
  4. Safety: explain why the change is safe (backward compat, deployment
     readiness, rollback implications) and note any trade-offs. Avoid
     overconfident claims like "no risk", "no downtime", or "can proceed
     without coordination" - instead, explain *how* rollback works and what
     it restores (e.g., "if issues arise, reverting restores the original
     behavior"). Focus on service impact (downtime, broken connections,
     failed requests) rather than data loss unless data loss is relevant.
  5. Summary: list of specific changes - only for large changes where it's
     hard to track what happened; skip if the diff is self-explanatory
- Do not make false claims about system state - verify before asserting
- Use lowercase module/service names without spaces (e.g., `devderpapp`, `bigid_db`)
- Do not use marketing or stylized names (e.g., "Dev DERP app" → `devderpapp`)
- Use markdown backticks to highlight technical terms for proper rendering:
  - File names and paths (e.g., `services-cert-chain.crt`, `/etc/ssl/certs/internal-ca-bundle.crt`)
  - Service names (e.g., `bkredis`, `powerdns`, `pgsql`)
  - Technical terms and identifiers (e.g., `-bundle.crt`, `internal-ca-bundle`)

## Code Style

- Python: Use `black` for formatting

## Merge Requests

- Title format: `TICKET-NUMBER: scope: description` (e.g., `PCM-5746: bigid_db: use proper CA bundle`)
- Extract ticket number from branch name if available (e.g., `panh/PCM-5746-bigid` → `PCM-5746`)
- Description/body:
  - Single commit: use the commit message body directly
  - Multiple commits: aggregate the commit message bodies into a cohesive description
