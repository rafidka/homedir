# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal utilities repository (`~/bin`) containing shell scripts and Python tools for system administration and development workflow automation. The repository is part of a Linux/macOS home directory setup.

## Common Development Commands

### Docker Management
- `docker-shell <container>` - Open shell in Docker container (auto-detects bash/sh, supports partial matching)
- `docker-clean [-f]` - Remove all containers and images (prompts for confirmation)
- `docker-purge [-f]` - Remove ALL Docker resources including volumes and networks (requires "yes" confirmation)

### Python Development
- `pyclean [--dry-run] [-f] [-v] [dir]` - Remove Python artifacts (venv, __pycache__, etc.)
  - Supports dry-run mode, force flag, verbose output, and custom directory
  - Uses `find` command for cross-platform compatibility

### Process Management
- `mem_usage <process>` - Monitor memory usage with OS detection (Linux/macOS)
  - Shows per-process breakdown for multiple instances
  - Formats output in MB/GB automatically
- `proctree [username] [-s|-p|-a]` - Display process tree with dependency checking
  - Falls back to `ps` if pstree unavailable
  - Provides OS-specific installation instructions

### File Operations
- `gsget <gs://path> [dest]` - Download from Google Cloud Storage with validation
- `sweep_sandbox [-d] [-v] [-a hours] [-p path]` - Clean old sandbox files
  - Configurable age threshold and path
  - Verbose mode shows sizes and access times
  - Dry-run mode for safe preview

### Utilities
- `sumcol [column]` - Sum numeric values from specified column (default: 1)
  - Reads from stdin, handles floats and integers
- `dotenv-export [file]` - Convert .env to shell exports
  - Handles quotes and special characters properly
  - Shows warnings for malformed lines

## Architecture Notes

### Script Organization
- All scripts are located in `~/bin` directory
- Mix of Bash shell scripts and Python 3 scripts
- Git completion and prompt helpers included (`git-completion.bash`, `git-prompt.sh`)

### Key Patterns
1. **Help system**: All scripts support `-h/--help` with detailed documentation
2. **Safety features**: Confirmation prompts, dry-run modes, dependency checking
3. **OS compatibility**: Platform detection, fallback commands, portable implementations
4. **Error handling**: Validate inputs, check dependencies, provide helpful error messages
5. **Python scripts**: Type hints, docstrings, proper error handling
6. **Bash scripts**: Consistent option parsing, proper quoting, error checking

### Development Standards
- **Shebangs**: `#!/bin/bash` for shell, `#!/usr/bin/env python3` for Python
- **Help flags**: All scripts implement `-h/--help` with usage examples
- **Exit codes**: 0 for success, 1 for general errors, proper error messages to stderr
- **Confirmation**: Destructive operations require confirmation or `-f/--force` flag
- **Dependencies**: Scripts check for required tools and suggest installation commands
- **Compatibility**: OS detection for Linux/macOS differences, POSIX-compliant where possible