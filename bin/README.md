# Personal Utilities Collection

A collection of shell scripts and Python utilities to help me in my daily tasks on Linux/macOS systems.

## Installation

Add this directory to your PATH by adding the following to your `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$HOME/bin:$PATH"
```

## Available Commands

### 🐳 Docker Management

#### `dshell`
SSH into a running Docker container with partial name matching support.

```bash
dshell <partial_container_name>
# Example: dshell web
```

- Automatically detects and uses bash if available, falls back to sh
- Shows list of running containers if no argument provided
- Supports partial container name/ID matching

#### `dclean`
Stop and remove all Docker containers and images.

```bash
dclean
```

⚠️ **Warning**: This will remove ALL containers and images on your system.

#### `dclean-all`
More aggressive Docker cleanup (removes volumes and networks).

```bash
dclean-all
```

---

### 🐍 Python Development

#### `clean_python_stuff`
Recursively clean Python development artifacts from the current directory tree.

```bash
clean_python_stuff
```

Removes:
- `.venv/` directories
- `__pycache__` directories
- `.pytest_cache/` directories
- `poetry_install.log` files

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

#### `my_procs`
Display process tree for the current user.

```bash
my_procs
```

---

### 📁 File Operations

#### `gsget`
Download files from Google Cloud Storage to the current directory.

```bash
gsget gs://bucket/path/to/file.txt
```

#### `copy_to_mac`
Copy files to a Mac machine via Tailscale network.

```bash
copy_to_mac <file>
# Example: copy_to_mac report.pdf
```

- Copies to `~/temp/` on the Mac
- Requires Tailscale setup and SSH access

#### `sweep_sandbox`
Clean up old files in the sandbox directory (`~/Workspace/sandbox`).

```bash
# Preview what would be deleted
sweep_sandbox --dry-run

# Actually delete old files
sweep_sandbox
```

- Removes files/folders not accessed in the last 12 hours
- Always use `--dry-run` first to preview changes

---

### 🔧 Other Utilities

#### `sum`
Simple calculation utility.

```bash
sum
```

#### `export_env`
Environment variable management utility.

```bash
export_env
```

## Requirements

- **Bash**: Version 4.0+
- **Python**: Version 3.6+
- **Docker**: For container management scripts
- **gsutil**: For Google Cloud Storage operations
- **Tailscale**: For cross-machine file copying

## Safety Notes

⚠️ **Destructive Operations**: 
- `dclean` and `dclean-all` will remove Docker resources
- `clean_python_stuff` will delete development artifacts
- `sweep_sandbox` will delete old files

Always use `--dry-run` flags when available to preview changes before execution.

## Contributing

This is a personal utilities collection. Feel free to fork and adapt for your own use.

## License

Personal use - adapt as needed for your own environment.