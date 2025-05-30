# Python Environment Management Guide for Ubuntu Linux

This guide provides step-by-step instructions for setting up and managing Python environments for your projects on Ubuntu Linux. Following these practices will help you maintain clean, isolated environments for each of your Python projects.

## 1. Current System State

Your system currently has:
- Python 3.12.3 installed (system Python)
- No pip package manager installed
- Using zsh shell

While you can use the system Python installation, it's better to use isolated environments for each project to:
- Avoid dependency conflicts between projects
- Prevent system-wide Python changes from breaking your projects
- Allow different projects to use different Python versions
- Make your projects more portable and reproducible

## 2. Initial Setup

### 2.1 Install pip

First, let's install pip, the Python package manager:

```bash
sudo apt-get update
sudo apt-get install -y python3-pip
```

### 2.2 Install System Dependencies

These dependencies are needed to build different Python versions:

```bash
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

### 2.3 Install pyenv

[pyenv](https://github.com/pyenv/pyenv) is a tool that lets you easily switch between multiple versions of Python:

```bash
curl https://pyenv.run | bash
```

### 2.4 Configure zsh for pyenv

Add the following to your `~/.zshrc` file to set up pyenv:

```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

Apply the changes:

```bash
source ~/.zshrc
```

Verify that pyenv is installed correctly:

```bash
pyenv --version
```

## 3. Python Version Management

### 3.1 List Available Python Versions

See all available Python versions:

```bash
pyenv install --list
```

### 3.2 Install a Python Version

Install a specific Python version (example uses 3.11.4):

```bash
pyenv install 3.11.4
```

This may take a few minutes as it builds Python from source.

### 3.3 Set a Global Python Version

Set a Python version as the default for your user:

```bash
pyenv global 3.11.4
```

Verify it worked:

```bash
python --version
```

### 3.4 Managing Multiple Python Versions

You can install multiple versions and switch between them:

```bash
# Install another version
pyenv install 3.10.12

# List installed versions
pyenv versions

# Switch between versions
pyenv global 3.10.12
python --version  # Should show 3.10.12

pyenv global 3.11.4
python --version  # Should show 3.11.4
```

## 4. Project Setup Process

For each new project, follow these steps:

### 4.1 Create a Project Directory

```bash
mkdir my_project
cd my_project
```

### 4.2 Set a Local Python Version

Set a Python version specifically for this project:

```bash
pyenv local 3.11.4
```

This creates a `.python-version` file in your project directory.

### 4.3 Create a Virtual Environment

Create an isolated environment for your project:

```bash
python -m venv .venv
```

### 4.4 Activate the Virtual Environment

```bash
source .venv/bin/activate
```

Your prompt should change to indicate the active environment, like:
```
(.venv) username@hostname:~/my_project$
```

### 4.5 Verify Environment

Check that you're using the correct Python and pip:

```bash
which python
python --version
python -m pip --version
```

### 4.6 Upgrade Basic Packages

```bash
python -m pip install --upgrade pip setuptools wheel
```

## 5. Project Dependencies Management

### 5.1 Installing Packages

Always install packages while your virtual environment is activated:

```bash
# Install a package
python -m pip install requests

# Install a specific version
python -m pip install requests==2.28.1
```

### 5.2 Creating a Requirements File

Save your project's dependencies to a file:

```bash
python -m pip freeze > requirements.txt
```

### 5.3 Installing from Requirements

To install dependencies on another system or environment:

```bash
python -m pip install -r requirements.txt
```

### 5.4 Deactivating the Environment

When you're done working on your project:

```bash
deactivate
```

## 6. Project Structure and Version Control

### 6.1 Initialize Git (Optional)

```bash
git init
```

### 6.2 Create a .gitignore File

Create a `.gitignore` file to exclude environment files and caches:

```bash
cat << EOF > .gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
*.so

# Virtual Environment
.venv/
venv/
ENV/

# IDE
.idea/
.vscode/
*.swp

# Distribution/packaging
dist/
build/
*.egg-info/
EOF
```

## 7. Best Practices

1. **One Environment Per Project**: Never mix dependencies between projects.

2. **Always Use Virtual Environments**: Even for small scripts, use virtual environments.

3. **Use `python -m pip` Instead of Just `pip`**: This ensures you're using the correct pip.

4. **Include a `requirements.txt` File**: Document your dependencies.

5. **Keep `.python-version` in Version Control**: But exclude the virtual environment folder.

6. **Regularly Update Dependencies**: Check for updates and security patches.

7. **Pin Exact Versions**: Use `==` in requirements for production to ensure reproducibility.

8. **Document Environment Setup**: Include setup instructions in your README.

## 8. Common Workflows

### 8.1 Starting a New Project

```bash
# Create project directory
mkdir new_project
cd new_project

# Set Python version
pyenv local 3.11.4

# Create and activate environment
python -m venv .venv
source .venv/bin/activate

# Set up version control
git init
# Create .gitignore as shown above

# Install initial dependencies
python -m pip install --upgrade pip setuptools wheel
python -m pip install requests  # Example package

# Save dependencies
python -m pip freeze > requirements.txt
```

### 8.2 Cloning an Existing Project

```bash
# Clone the repository
git clone https://github.com/username/project.git
cd project

# Ensure you have the right Python version
# (Assuming .python-version exists)
pyenv install $(cat .python-version) --skip-existing

# Create and activate environment
python -m venv .venv
source .venv/bin/activate

# Install dependencies
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements.txt
```

### 8.3 Updating Dependencies

```bash
# Activate environment
source .venv/bin/activate

# Update a specific package
python -m pip install --upgrade requests

# Update all packages (use with caution)
python -m pip install --upgrade $(python -m pip freeze | cut -d= -f1)

# Update requirements.txt
python -m pip freeze > requirements.txt
```

## 9. Troubleshooting

### 9.1 pyenv Installation Issues

If pyenv installation fails:
```bash
# Check if you have all dependencies
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Try manual installation
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```

### 9.2 Python Build Failures

If Python installation fails:
```bash
# Install specific build dependencies
sudo apt-get install -y python3-dev

# Try with verbose output
PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -v 3.11.4
```

### 9.3 Virtual Environment Issues

If you can't activate the environment:
```bash
# Recreate the environment
rm -rf .venv
python -m venv .venv
```

### 9.4 Package Installation Failures

```bash
# Update pip first
python -m pip install --upgrade pip

# Install with verbose output
python -m pip install -v package_name
```

## 10. Quick Reference

### 10.1 Essential Commands

```bash
# pyenv commands
pyenv install --list       # List available Python versions
pyenv install 3.11.4       # Install Python 3.11.4
pyenv versions             # List installed versions
pyenv global 3.11.4        # Set global Python version
pyenv local 3.11.4         # Set local Python version

# Virtual environment commands
python -m venv .venv       # Create virtual environment
source .venv/bin/activate  # Activate environment (zsh/bash)
deactivate                 # Deactivate environment

# pip commands
python -m pip install package_name      # Install package
python -m pip install -r requirements.txt  # Install from requirements
python -m pip freeze > requirements.txt    # Save requirements
python -m pip list                      # List installed packages
python -m pip show package_name         # Show package info
```

### 10.2 Important Files and Locations

- `~/.pyenv/` - pyenv installation directory
- `~/.pyenv/versions/` - Installed Python versions
- `.python-version` - Local Python version specification
- `.venv/` - Virtual environment directory
- `requirements.txt` - Project dependencies

### 10.3 Useful pyenv Plugins

- [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) - Simplifies virtual environment management
- [pyenv-update](https://github.com/pyenv/pyenv-update) - Makes updating pyenv easier
- [pyenv-doctor](https://github.com/pyenv/pyenv-doctor) - Verifies pyenv installation

Install a plugin:
```bash
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
```

---

This guide should help you set up and manage Python environments for your projects. For more detailed information, refer to the official documentation for [pyenv](https://github.com/pyenv/pyenv), [venv](https://docs.python.org/3/library/venv.html), and [pip](https://pip.pypa.io/en/stable/).

