# README

## MacOS Brew Install

`brew install node pnpm uv python3 yarn deno luarocks pipx rust go`

## TODO

## To Watch

- [Cursor Tab Clone](https://github.com/reachingforthejack/cursortab.nvim)

## Quick Cheatsheet

Inside `Ex`: `o` opens the default application of highlighted file
`v` opens a vertical one (Same with my oil setup rn)
`x` opens horizontal

## Vim Commands I Want to get Better At

- `<C-r>` in insert mode -> Shows registers

## Acknowledgments

Thank you Primeagen, craftzdog, TJDev for your videos and config files to help me set up an environment I really enjoy!

## Setup Workflow

### Non-negotiable Essentials (imo)

- Aerospace for MacOS version of i3 window management
- Rectangle for summoning my most used apps from my keyboard only
- Karabiner for assigning a superkey
- BTT for external mouse scroll QOL
- Obsidian for my note taking and "second brain"
- Todoist for.... well... yeah
- Fantastical to integrade my todos and fast event navigation
- Anki for my daily flashcards to keep being sharp

## Other Dailies that can be user preferance

- Vivaldi browser... like the workspaces so far since Firefox stopped caring about their security

## Claude Prompts

```plaintext
## Role
You are a **Senior fullstack nextjs, react, create-t3-app developer**.

## Design Style
- A **perfect balance** between **elegant minimalism* and **functional design**.
- **Soft, refreshing gradient colors* that seamlessly integrate with the brand palette.
- **Well-proportioned white space"* for a clean layout.
- **Light and immersive** user experience.
- **Clear information hierarchy"* using **subtle shadows and modular card layouts**
- **Natural focus** on core functionalities.
- **Refined rounded corners"*.
- **Delicate micro-interactions**.
- **Comfortable visual proportions**.
- **Accent colors** chosen based on the app type.
- Product will be heavily inspired by Stripe.com design
- My technical stack is create-t3-app, tailwindcss, framer-motion, shadcn/ui, nextjs, react
- Use supabase code when creating backend
- Use clerk code when creating login
- Use stripe code when creating payments

## Technical Specifications
1. Each page should be mobile friendly as well as desktop friendly.
2. **Icons**: Use an **online vector icon library* (icons **must not** have background blocks, baseplates, or outer frames).
3. **Images**: Must be sourced from **open-source image websites** and linked directly.
4. "*Styles**: Use **Tailwind CSS** via **CDN** for styling.
6. **Do not display non-mobile elements**, such as scrollbars.
8. Use Shadcn/ui for the UI components
9, Use framer-motion for animations

## Task
Respond with "I am ready to start" to receive the design brief.
```

## Anki Plugins

- Heatmap: 1771074083
- Syntax Highlighting: 566351439

## Claude Desktop MCP with Smithy

```bash
npx -y @smithery/cli@latest install @smithery/toolbox --client claude
npx -y @smithery/cli@latest install @wonderwhy-er/desktop-commander --client claude
npx -y @smithery/cli install @alioshr/memory-bank-mcp --client claude
npx -y @smithery/cli@latest install @smithery-ai/server-sequential-thinking --client claude
npx -y @smithery/cli@latest install @Dhravya/apple-mcp --client claude
npx -y @smithery/cli@latest install @21st-dev/magic-mcp --client claude
```
