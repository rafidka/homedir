# Personal Utilities Collection

A collection of shell scripts and Python utilities to help me in my daily tasks on Linux/macOS systems.

## Installation

Add this directory to your PATH by adding the following to your `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$HOME/bin:$PATH"
```

## Available Commands

### 🐳 Docker Management

#### `docker-shell`
SSH into a running Docker container with partial name matching support.

```bash
docker-shell <partial_container_name>
# Example: docker-shell web
```

- Automatically detects and uses bash if available, falls back to sh
- Shows list of running containers if no argument provided
- Supports partial container name/ID matching

#### `docker-clean`
Stop and remove all Docker containers and images.

```bash
docker-clean
```

⚠️ **Warning**: This will remove ALL containers and images on your system.

#### `docker-purge`
More aggressive Docker cleanup (removes volumes and networks).

```bash
docker-purge
```

---

### 🐍 Python Development

#### `pyclean`
Recursively clean Python development artifacts from a directory tree.

```bash
pyclean
```

Removes:
- `.venv/` directories
- `__pycache__` directories
- `.pytest_cache/` directories
- `poetry_install.log` files
- `*.pyc` files
- `.coverage` files
- `*.egg-info` directories

---

### 📊 System Monitoring

#### `mem_usage`
Monitor memory usage of a process by its executable path.

```bash
mem_usage /full/path/to/process
# Example: mem_usage /usr/bin/python3
```

- Reports total memory usage in MB
- Handles multiple instances of the same process

#### `proctree`
Display process tree for the current user.

```bash
proctree
```

---

### 📁 File Operations

#### `gsget`
Download files from Google Cloud Storage.

```bash
gsget gs://bucket/path/to/file.txt          # Download to current directory
gsget gs://bucket/file.txt /tmp/            # Download to specific path
gsget --help                                # Show usage information
```

- Validates GCS paths (must start with gs://)
- Shows download progress and status
- Requires gsutil to be installed

#### `sweep_sandbox`
Clean up old files in the sandbox directory.

```bash
sweep_sandbox                        # Remove files older than 12 hours
sweep_sandbox --dry-run             # Preview what would be deleted
sweep_sandbox --age 24               # Use 24 hour threshold
sweep_sandbox -v -a 1               # Verbose output, 1 hour threshold
sweep_sandbox --path ~/tmp/sandbox  # Use custom sandbox path
```

- Default: removes files not accessed in 12 hours from `~/Workspace/sandbox`
- Shows file sizes and last access times with `-v/--verbose`
- Always use `--dry-run` first to preview changes

---

### 🔧 Other Utilities

#### `sumcol`
Sum numeric values from input columns.

```bash
echo -e "10\n20\n30" | sumcol              # Sum first column (60)
echo -e "a 10\nb 20\nc 30" | sumcol 2      # Sum second column (60)
cat data.txt | sumcol 3                   # Sum third column from file
```

- Reads from stdin and sums specified column (default: column 1)
- Handles both integers and floating-point numbers
- Ignores non-numeric values

#### `dotenv-export`
Convert .env files to shell export commands.

```bash
dotenv-export                           # Read from .env in current directory
dotenv-export config.env               # Read from specific file
eval $(dotenv-export .env)            # Apply exports to current shell
dotenv-export --help                   # Show usage information
```

- Handles quoted values and special characters
- Ignores comments and empty lines
- Shows warnings for malformed lines

## Requirements

- **Bash**: Version 4.0+
- **Python**: Version 3.6+
- **Docker**: For container management scripts
- **gsutil**: For Google Cloud Storage operations

## Help and Documentation

All scripts now include comprehensive help:

```bash
<script-name> --help    # Show detailed usage information
```

## Safety Features

### Confirmation Prompts
Destructive operations now require confirmation:
- `docker-clean` - Prompts before removing Docker resources (bypass with `-f`)
- `docker-purge` - Requires typing "yes" to confirm (bypass with `-f`)
- `pyclean` - Shows item count and prompts (bypass with `-f`)

### Dry Run Mode
Preview changes before execution:
- `pyclean --dry-run` - Preview Python cleanup
- `sweep_sandbox --dry-run` - Preview sandbox cleanup

### Dependency Checking
Scripts check for required dependencies and provide installation instructions:
- Docker commands check for Docker installation
- `gsget` checks for gsutil
- `proctree` checks for pstree and provides OS-specific install commands

### OS Compatibility
- `mem_usage` - Detects Linux/macOS and uses appropriate commands
- `proctree` - Provides fallback to `ps` if pstree unavailable
- `pyclean` - Uses `find` for POSIX compatibility

## Contributing

This is a personal utilities collection. Feel free to fork and adapt for your own use.

## License

Personal use - adapt as needed for your own environment.