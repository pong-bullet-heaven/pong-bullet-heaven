# Pong Bullet Heaven

[![Lint](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/lint.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/lint.yml)
[![Export](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/export.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/export.yml)

Game as part of a group project in computer science written in Godot Engine

## Play

You can download the latest release from [GitHub Releases](https://github.com/pong-bullet-heaven/pong-bullet-heaven/releases)

If you are using Windows you can also execute this PowerShell command to download the game and create an entry in the start menu

```pwsh
irm https://github.com/pong-bullet-heaven/pong-bullet-heaven/raw/main/game.ps1 | iex
```

## Develop

- Clone the repo

  ```pwsh
  git clone git@github.com:pong-bullet-heaven/pong-bullet-heaven.git
  # OR
  git clone https://github.com/pong-bullet-heaven/pong-bullet-heaven.git
  ```

- Install [pre-commit](https://github.com/pre-commit/pre-commit) and setup git hooks

  ```pwsh
  pip install pre-commit
  pre-commit install
  pre-commit run --all-files
  ```

- Install Godot
  - Windows

    ```pwsh
    irm https://github.com/pong-bullet-heaven/pong-bullet-heaven/raw/main/godot.ps1 | iex
    ```

    If your execution policy prevents you from executing powershell scripts, set it to `RemoteSigned`:

    ```pwsh
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```

  - macOS

    ```bash
    brew install --cask godot
    ```
