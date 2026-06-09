---
name: computer-use
description: Local Windows Computer Use compatibility helper for Codex Desktop. Provides the @oai/sky paths that the Desktop app expects when CODEX_ELECTRON_ENABLE_WINDOWS_COMPUTER_USE=1.
---

# Computer Use

This local compatibility plugin is installed by the codex-windows-fast-patch skill. It supplies the Windows helper transport paths that Codex Desktop resolves for Computer Use.

The Desktop app must be launched with `CODEX_ELECTRON_ENABLE_WINDOWS_COMPUTER_USE=1`. The installer writes that as a user environment variable, so restart Codex after installation.
