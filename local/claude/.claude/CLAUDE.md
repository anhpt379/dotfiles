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
  - Non-monorepo: capitalize the first letter
    (e.g., `Pin jinja2>=3.1`, not `pin jinja2>=3.1`)
  - Monorepo: keep the letter after `:` lowercase, since the scope
    already carries the "sentence start" weight
    (e.g., `nvim: unpin treesitter version`,
    not `nvim: Unpin treesitter version`)
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
     Skip the safety note entirely when the only thing left to say is
     tautological - "reverting restores the prior behavior" is true of
     every commit and adds no information. Only include rollback prose
     when there is something non-obvious to convey (a migration step, a
     feature flag, a coordinated deploy, a state that does not roll back
     cleanly).
  5. Summary: list of specific changes - only for large changes where it's
     hard to track what happened; skip if the diff is self-explanatory
- Do not make false claims about system state - verify before asserting
- In body prose, use narrative third-person phrasing (e.g., "This commit
  updates X to Y", "The new setup presents the full chain") rather than
  bare imperatives ("Update X to Y"). The subject line still uses
  imperative.
- Avoid unusual or archaic words in technical prose (e.g., "inert",
  "nascent", "salient"). Prefer everyday alternatives such as "has no
  runtime effect" or "commented out today".
- For no-op changes (edits to commented-out lines, docs, or examples),
  keep the safety paragraph to one sentence acknowledging there is no
  runtime effect. Do not invent conditional rollback scenarios when
  there is no real rollback mechanism to describe - empty "if X later
  happens, reverting Y restores Z" clauses read as padding.
- Use lowercase module/service names without spaces (e.g., devderpapp, bigid_db)
- Do not use marketing or stylized names (e.g., "Dev DERP app" → devderpapp)
- Do not use markdown backticks in commit messages unless absolutely
  necessary (e.g., a symbol whose meaning would be ambiguous without
  them). Plain paths, filenames, service names, and identifiers read
  fine as bare text in `git log` and are harder to read with stray
  backtick noise. Backticks belong in MR descriptions, not commits.

## Code Style

- Python: Use `black` for formatting

## Merge Requests

- Title format: `TICKET-NUMBER: scope: description` (e.g., `PCM-5746: bigid_db: use proper CA bundle`)
- Extract ticket number from branch name if available (e.g., `panh/PCM-5746-bigid` → `PCM-5746`)
- Description/body:
  - Single commit: use the commit message body directly, but add
    markdown backticks around technical terms (file names and paths,
    service names, identifiers) for proper rendering in GitLab/GitHub.
  - Multiple commits: aggregate the commit message bodies into a
    cohesive description, adding backticks around technical terms as
    above.
