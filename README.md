# README

## TODO

- [ ] Share Xavrr + NvChad + Kickstart + ThePrimagen + Craftzdog Setup
- [ ] Share workflow with AI
- [ ] Share what universal tooling I use to make life easier
- [ ] Create script for said universal tooling
- [ ] Philosophy
- [ ] Figure out how to make your tabline and statusline cleaner without chadrc

## Software I Use

`brew install evil-helix`

## CLI Installs

`brew install mise`

### Claude Code + Opencode

`npm install -g @anthropic-ai/claude-code`
`brew install sst/tap/opencode      # macOS`

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

### Random But Useful

#### Claude Error to Symlink Fix

`sudo ln -sf "$(which node)" /usr/local/bin/node && sudo ln -sf "$(which npx)" /usr/local/bin/npx`
