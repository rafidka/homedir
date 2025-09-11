# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal utilities repository (`~/bin`) containing shell scripts and Python tools for system administration and development workflow automation. The repository is part of a Linux/macOS home directory setup.

## Common Development Commands

### Docker Management
- `dshell <container_name>` - SSH into a running Docker container (supports partial name matching)
- `dclean` - Stop and remove all Docker containers and images
- `dclean-all` - More aggressive Docker cleanup (check script for details)

### Python Development
- `clean_python_stuff` - Recursively removes `.venv/`, `__pycache__`, `.pytest_cache/`, and `poetry_install.log` from current directory tree

### Process Management
- `mem_usage /path/to/process` - Monitor memory usage of a process by its executable path
- `my_procs` - Display process tree for current user

### File Operations
- `gsget <gs://path>` - Download file from Google Cloud Storage to current directory
- `copy_to_mac <file>` - Copy file to Mac via Tailscale network
- `sweep_sandbox` - Clean up old files in ~/Workspace/sandbox (files unused for >12 hours)
  - Use `--dry-run` flag to preview what would be deleted

### Utilities
- `sum` - Calculation utility (check implementation for details)
- `export_env` - Environment variable management

## Architecture Notes

### Script Organization
- All scripts are located in `~/bin` directory
- Mix of Bash shell scripts and Python 3 scripts
- Git completion and prompt helpers included (`git-completion.bash`, `git-prompt.sh`)

### Key Patterns
1. **Docker scripts**: Use pattern matching for container names and automatic shell detection (bash vs sh)
2. **Python scripts**: Use argparse for CLI arguments, subprocess for system commands
3. **Cleanup scripts**: Implement dry-run functionality for safety
4. **Network scripts**: Leverage Tailscale for cross-machine operations

### Development Considerations
- Scripts assume Linux/macOS environment
- Python scripts use `#!/usr/bin/env python3` shebang for portability
- Docker scripts handle edge cases (no containers, multiple matches)
- File operations use Path objects from pathlib for better cross-platform support