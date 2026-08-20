This machine is managed by nix-darwin + home-manager from `~/src/github.com/lukebarton/flake`.

## Writing

Write prose in ASD-STE100 simplified technical English by default: one idea per
sentence, active voice, literal words, a term used one way throughout. The
`asd-ste100` skill holds the full rules — load it for a deliberate rewrite pass.

## Naming

**A feature has a name. Nothing else gets one.** Feature names are deliberate and
permanent: a user sees them, so they stay. The vocabulary that grows off the back
of one is not deliberate — a feature named for eating acquires "meals", then a
"pantry" with "doors" and a "larder". Don't let them accumulate. Say what
the thing is: a capture in a game, a neighbor reach graph, a cluster of capturable neighbors.
When you catch yourself extending a feature's metaphor, name the concept instead.

**Everything internal gets its literal name, everywhere** — identifiers, file
names, ADR titles, comments, docs, commit messages, and anything you say to me.
Communicate the intent clearly. A name that needs a story before it means anything is the wrong
name. Nicknames already in a codebase are a debt, not a precedent: leave new ones
unwritten, and rename where you touch.
