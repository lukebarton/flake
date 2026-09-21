# CLAUDE.md

## Shorthand

- WFMC - Wait for my confirmation before changing any code
- SAE: Summarise and Explain

## Git

- Use conventional commit messages, unless the project specifies its own message requirements
- Only raise PRs if the project or user requires it
- Use a new worktree+branch when asked to work on an issue from an issue/ticket tracking system from `main`

## Issue tracking

Statuses:

- Todo: Ready for implementation
- In progress: Being actioned
- In review: Being reviewed post-completion by the user
- Done: Accepted by the user and merged into main

Before updating or implementing tickets/issues from issue tracking systems:
- 
- Read the comments on the issue
- Read related issues and their comments
- Use tracker provided branch name if available

When you've committed the work, move the issue to awaiting review and:
- Add a comment summary; include:
  1. A link to the Claude Code session that did the work (the `https://claude.ai/code/session_...` URL from the harness instructions).
  2. A link to the branch on GitHub
  3. A 2-sentence tldr (if necessary)
  4. A clear explanation of what was done, at a level of detail appropriate to the task, giving priority to explaining new interfaces and interface changes — what downstream code/users can now do or must now do differently.

Once the work is merged into `main`, move the issue to Complete/Done.

## Relevance

If the user tries to execute unrelated follow on work, suggest they start a new session then ask them if you should continue.

## Communication style

Write plainly and concretely in everything: chat replies, catch-up summaries, commit messages, Linear comments, and docs. Use ordinary sentences and the real names of things. A technical term is fine only when it's clear what it refers to, why the user is reading the sentence, and what response (if any) is needed from them.

Explain anything beyond what an experienced generalist software engineer would know — especially language-specific behaviour and anything from a specialist area such as data structures, algorithms, complexity, or optimisation. Calibrate depth to the understanding the user has demonstrated in the conversation, not to assumptions. Test their understanding only when a decision depends on it.

Use a metaphor only when something is hard to explain plainly, when the user isn't understanding, or when the metaphor is unusually apt. State the plain version first and keep the metaphor brief. Never carry a metaphor into code, names, commit messages, Linear, or docs — with one exception: a narrowly scoped metaphor inside documentation to explain one specific thing that resists plain explanation.

After multi-step autonomous work, assume the user saw none of the intermediate output. Summarise as bullets where each item leads with the cause or symptom, then the fix, then the result and its trade-offs ("it was overcounting on two days in March and October; the cause was X; fixed by Y, which means Z"). Report problems encountered, unexpected fixes, deviations from the plan, repeated attempts at things that should have been easy, and anything that didn't turn out as intended. Omit routine successes. If the summary is long, open with a one-line bold statement of the outcome.

When something is needed from the user, make the ask obvious and skimmable — never buried mid-sentence or wrapped in hedging. There's no need to explicitly state when nothing is needed.