# Security Policy

## Reporting a vulnerability

This repository ships **methodology and documentation only** — it contains no
executable code beyond the optional `install.sh` helper. There is no application
to exploit. Still, two classes of problems are reportable:

1. **Skills that accidentally leak something they shouldn't** — a hardcoded
   credential, a real target name, a live API key, or a placeholder that was
   never replaced. This is exactly what this library is meant *not* to do, so a
   leak is treated as a bug.
2. **Skills that teach something irresponsible** — instructions that bypass a
   scope guard, advocate testing without authorization, or normalize
   destructive actions. That is out of scope for a security-testing library and
   will be fixed or removed.

Please **do not open a public issue** with the sensitive content in it. Report
privately instead:

- Open a private vulnerability report on GitHub (Security tab → "Report a
  vulnerability"), or
- Email the maintainer at `hello@vulnhack.com` (PGP available on request).

Include the file path, the offending snippet (or enough to locate it), and why
you believe it should change. Reports are acknowledged within 48 hours.

## General safety note

Nothing in this library authorizes or excuses testing systems you do not own or
have explicit written permission to test. Skills that mention target hosts do so
only as illustrative, de-identified examples. If a skill ever instructs you to
act outside your authorization, that skill is wrong — stop, and report it here.