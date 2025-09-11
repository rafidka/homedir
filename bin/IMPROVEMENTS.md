# Script Improvement Suggestions

## 🚨 Critical Issues

### 1. **export_env** - Wrong Shebang
- **Issue**: Uses `#!/bin/python3` instead of `#!/usr/bin/env python3`
- **Impact**: Will fail on most systems where python3 is in `/usr/bin/`
- **Fix**: Change to `#!/usr/bin/env python3`

### 2. **dclean & dclean-all** - Command Failures on Empty State
- **Issue**: Commands fail when no containers/volumes/networks exist
- **Impact**: Script exits with error instead of gracefully handling empty state
- **Fix**: Add `2>/dev/null` or check if list is empty before executing

### 3. **gsget** - Missing Shebang
- **Issue**: No shebang line, relies on shell interpretation
- **Fix**: Add `#!/bin/bash` at the top

### 4. **sum** - Missing Shebang
- **Issue**: No shebang line, just a bare awk command
- **Fix**: Add `#!/bin/bash` or convert to proper script

## 📋 Missing Features & Documentation

### 1. **All Scripts** - No Help/Usage Information
Most scripts lack `-h` or `--help` flags. Recommended additions:

#### dclean & dclean-all
```bash
# Add at beginning:
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo "Usage: $(basename $0)"
    echo "Remove all Docker containers and images"
    echo "WARNING: This is destructive and cannot be undone!"
    exit 0
fi
```

#### clean_python_stuff
- Add `--help` flag
- Add `--dry-run` option to preview what would be deleted
- Add option to specify directory (currently uses `$PWD`)

### 2. **export_env** - Poor Error Handling
- No error handling for malformed lines
- No check if file exists
- Should handle quoted values properly

## 🖥️ OS Compatibility Issues

### 1. **my_procs** - Linux-specific
- Uses `pstree` which may not be installed by default on macOS
- **Fix**: Add dependency check or use `ps` as fallback

### 2. **mem_usage** - Linux-specific Implementation
- `pgrep -f` behaves differently on macOS
- RSS calculation may differ between platforms
- **Fix**: Add platform detection and use appropriate commands

### 3. **clean_python_stuff** - Bash 4+ Required
- Uses `globstar` which requires Bash 4+
- macOS ships with Bash 3.2 by default
- **Fix**: Use `find` command instead for better compatibility

## 🔧 Code Quality Improvements

### 1. **dshell** - Commented Out Code
- Contains 17 lines of commented old implementation
- **Fix**: Remove commented code or move to version control history

### 2. **clean_python_stuff** - Dangerous rm -rf
- Uses `set -xe` which will echo all commands (including deletions)
- No confirmation prompt for destructive operation
- **Fix**: Add confirmation or dry-run mode

### 3. **sweep_sandbox** - Good Example
- Already has `--dry-run` flag ✅
- Good error handling ✅
- Could benefit from `-v/--verbose` flag for more details

## 📦 Missing Dependency Checks

Scripts should check for required commands:

### Template for Dependency Checking
```bash
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is not installed" >&2
        exit 1
    fi
}

# Usage:
check_dependency docker
check_dependency gsutil
```

### Dependencies by Script:
- **dshell, dclean, dclean-all**: `docker`
- **gsget**: `gsutil`
- **my_procs**: `pstree`

## 🏷️ Naming Suggestions

### Current Names → Better Alternatives
1. **dshell** → **docker-shell** or **dsh** (shorter)
2. **dclean** → **docker-clean** or **docker-purge**
3. **clean_python_stuff** → **pyclean** or **python-clean**
4. **my_procs** → **myprocs** or **proctree**
5. **gsget** → Good as is ✅
6. **sum** → **sumcol** or **column-sum** (more descriptive)
7. **export_env** → **env2export** or **dotenv-export**

## 🎯 Additional Suggestions

### 1. Create a Setup/Install Script
```bash
#!/bin/bash
# install.sh
echo "Checking dependencies..."
# Check for all required tools
# Add to PATH
# Set up any configs
```

### 2. Add Configuration File Support
Create `~/.config/bin-utils/config.yaml` for:
- Default sandbox age threshold
- Docker cleanup preferences

### 3. Improve sum Utility
Current implementation only sums first column. Consider:
```bash
#!/bin/bash
# Sum any column (default: 1)
COLUMN="${1:-1}"
awk -v col="$COLUMN" '{sum += $col} END {print sum}'
```

### 4. Add Logging
For destructive operations, consider logging to `~/.local/share/bin-utils/logs/`:
- What was deleted
- When operations were run
- Any errors encountered

### 5. Create Man Pages or Markdown Docs
For each script, create a `.md` file with:
- Full usage examples
- Options and flags
- Common use cases
- Troubleshooting

### 6. Unit Tests
Consider adding simple test scripts:
```bash
# test_dshell.sh
docker run -d --name test-container alpine sleep 100
./dshell test-container
docker stop test-container
docker rm test-container
```

## 🎯 Priority Fixes

1. **HIGH**: Fix `export_env` shebang
2. **HIGH**: Add error handling to `dclean` and `dclean-all`
3. **MEDIUM**: Add help flags to all scripts
4. **MEDIUM**: Remove commented code from `dshell`
5. **LOW**: Standardize naming conventions
6. **LOW**: Add dependency checks