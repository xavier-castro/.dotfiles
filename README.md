# README

This is my macos setup with my generic configs. This is assuming a fresh install of macOS.

## Installation

You need to install [homebrew](https://brew.sh/) and [zsh](https://github.com/robbyrussell/oh-my-zsh) before the install scripts work.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # Install rust
```

### MacOS apps

I really can't live without [raycast](https://www.raycast.com/). Complete game changer.

- Fantastical for scheduling. [App Store](https://apps.apple.com/us/app/fantastical-calendar/id975937182?mt=12)
- Todoist for task management. [App Store](https://apps.apple.com/us/app/todoist-to-do-list-calendar/id585829637?mt=12)
- [1Password](https://1password.com/downloads/mac)

### Aerospace

- Github [here](https://github.com/nikitabobko/AeroSpace)

### Karabiner

- Install [here](https://karabiner-elements.pqrs.org/)

* Traverse inside `.dotfiles/karabiner` and `yarn` followed by `yarn run build`

### Claude Code + Opencode + Gemini

`npm install -g @anthropic-ai/claude-code`
`npm install -g @google/gemini-cli``
`brew install sst/tap/opencode # macOS`

#### Claude All-in-One MCP Config

- For me, the less MCP's the ai has to decide between the better off you are. the all in one search tool is amazing

```json
{
  "mcpServers": {
    "mcp-sequentialthinking-tools": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "mcp-sequentialthinking-tools"]
    },
    "mcp-omnisearch": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "mcp-omnisearch"],
      "env": {
        "TAVILY_API_KEY": "",
        "BRAVE_API_KEY": "",
        "KAGI_API_KEY": "",
        "PERPLEXITY_API_KEY": "",
        "JINA_AI_API_KEY": ""
      }
    }
  }
}
```

## Note Taking

For Note taking and bookmarking I use `nb` that is being synced in my Dropbox for ease of use and editing on the go if I have to
`brew install xwmx/taps/nb --head`

## LSPs I had to manually install

```sh
brew install marksman
brew install dprint
brew install lua-language-server
brew install mise
```

## Notes on Docker

Despite Docker Desktop being notoriously slow for Mac, it is still my go-to. I am aware of Orbstack but what is holding me with docker desktop is its easy MCP tooling install which I rely heavily on

## Random But Useful

### Claude Error to Symlink Fix

`sudo ln -sf "$(which node)" /usr/local/bin/node && sudo ln -sf "$(which npx)" /usr/local/bin/npx`

### tmux-sessionizer denied permissions

`chmod +x ~/.dotfiles/bin/.local/scripts/tmux-sessionizer`

### Aerospace and Mission Control Not Playing Along

`defaults write com.apple.dock expose-group-apps -bool true && killall Dock`
