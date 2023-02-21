# Pong Bullet Heaven

[![Lint](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/lint.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/lint.yml)
[![Export](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/export.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/export.yml)

Game as part of a group project in computer science written in Godot Engine

## Setting up

### Windows

This will clone the repo and help you download godot and automatically create a start menu entry.

```pwsh
git clone git@github.com:pong-bullet-heaven/pong-bullet-heaven.git
# OR
git clone https://github.com/pong-bullet-heaven/pong-bullet-heaven.git

cd pong-bullet-heaven
./setup-godot.ps1
```

If your execution policy prevents you from executing powershell scripts, set it to `RemoteSigned`:

```pwsh
Set-ExecutionPolicy RemoteSigned
```

Install [pre-commit](https://github.com/pre-commit/pre-commit) and setup git hooks

```pwsh
pip install pre-commit
pre-commit install
pre-commit run --all-files
```
