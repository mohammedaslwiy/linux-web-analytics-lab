# Portfolio preparation

## Origin

Mohammed Abdulwareth developed the original `beleg` project for Praktische Grundlagen der Informatik at HTW Berlin and stored it on the university's GitLab. The reviewed local copy contained 38 commits on `main`, deployment configuration, Bash scripts and German course notes.

The portfolio edition was prepared with AI assistance for review, documentation, script fixes and tests. The original academic work and this later assisted preparation are separate stages. This repository demonstrates learning and deployment configuration around existing applications, not authorship of those applications.

## Changes in this edition

- Preserved the German README as `docs/course-notes-de.md`; added an English project README with actual run instructions.
- Resolved checked-in merge-conflict markers in the prerequisite installer.
- Replaced hard-coded university destinations with an explicit rsync destination argument.
- Removed global container deletion and network pruning from deployment.
- Added local random-secret initialization and ignored real `.env` files and editor swap files.
- Read configuration as text and validated it instead of sourcing `.env` as shell code.
- Made Compose port settings agree with the configuration and kept PostgreSQL off host ports.
- Added PostgreSQL readiness checks before Umami starts.
- Kept host services bound to localhost by default and documented SSH tunneling for VM access.
- Rendered the page from its original template, leaving tracking disabled until a website ID is configured.
- Removed duplicate/unserved HTML and the unused sample text file from the publication copy.
- Replaced the old placeholder GitLab job, which referenced a missing file, and added GitHub checks.
- Left automatic systemd integration for a later Linux-tested revision instead of publishing an unverified startup script.

## Git history and credentials

The original history contains a tracked `deploy/.env` with credentials. Simply deleting that file in a later commit would leave its earlier contents accessible. This GitHub repository therefore starts from a clean publication snapshot. The original local GitLab checkout and its history were kept unchanged.

Credentials from the old project must be changed if that deployment is still in use. Do not publish the old `.git` directory or push its branches to this public repository. A future history-preserving migration would need a separate redaction audit.

## Validation

- Bash syntax and behavior tests run with Git Bash on Windows.
- CI validates Compose without starting the services.
- The review environment has no installed Linux container runtime. A new end-to-end deployment on Linux and real service screenshots remain outstanding.

No live university server or existing container deployment was changed during portfolio preparation.
