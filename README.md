# Pong Bullet Heaven

[![Lint](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/lint.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/lint.yml)
[![Export](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/export.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/export.yml)
[![Pages](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/pages.yml/badge.svg)](https://github.com/pong-bullet-heaven/pong-bullet-heaven/actions/workflows/pages.yml)

Game as part of a group project in computer science written in Godot Engine

## Credits

### Game Engine

* Godot Engine: <https://godotengine.org/license>

### Game Development

* Game Designer: [@HenrikNeffe](https://github.com/HenrikNeffe) [@yrtemmys](https://github.com/yrtemmys)
* Game Programmer: [@DeltaPi314](https://github.com/DeltaPi314) [@HenrikNeffe](https://github.com/HenrikNeffe) [@marlene-dev](https://github.com/marlene-dev) [@masterflitzer](https://github.com/masterflitzer)
* Game Artist: [@icaroboaventura](https://github.com/icaroboaventura) [@yrtemmys](https://github.com/yrtemmys)
* Docs: [@marlene-dev](https://github.com/marlene-dev)

### Music

* Background Music

  ```txt
  Popcorn - Main Loop - Steven O'Brien
  ------------------------------------------
  Music by: <https://www.steven-obrien.net/>
  ```

## Play

You can download the latest release from [GitHub Releases](https://github.com/pong-bullet-heaven/pong-bullet-heaven/releases/latest) or play the web version on [GitHub Pages](https://pong-bullet-heaven.github.io/pong-bullet-heaven)

If you are using Windows, you can also run this command in PowerShell to download the game and automatically create an entry in the start menu:

```pwsh
irm https://github.com/pong-bullet-heaven/pong-bullet-heaven/raw/main/game.ps1 | iex
```

## Develop

* Clone the repo

  ```bash
  git clone git@github.com:pong-bullet-heaven/pong-bullet-heaven.git
  # OR
  git clone https://github.com/pong-bullet-heaven/pong-bullet-heaven.git
  ```

* Install python dependencies

  ```bash
  pip install -r requirements.txt
  ```

* Setup git hooks with [pre-commit](https://github.com/pre-commit/pre-commit)

  ```bash
  pre-commit install
  pre-commit run --all-files
  ```

* Install Godot
  * Windows

    ```pwsh
    irm https://github.com/pong-bullet-heaven/pong-bullet-heaven/raw/main/godot.ps1 | iex
    ```

    If your execution policy prevents you from executing powershell scripts, set it to `RemoteSigned`:

    ```pwsh
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```

  * macOS

    ```bash
    brew install --cask godot
    ```
