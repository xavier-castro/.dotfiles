"use strict";
// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.
//
const backgroundColor = "#211d1d";
const foregroundColor = "#839496";
const borderColor = "transparent";

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: "stable",
    macOptionSelectionMode: "vertical",
    modifierKeys: {
      altIsMeta: true,
      cmdIsMeta: false,
    },
    // default font size in pixels for all tabs
    fontSize: 16,
    // font family with optional fallbacks
    fontFamily: "Inconsolata NFM",
    fontWeight: "normal",
    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: "bold",
    // line height as a relative unit
    lineHeight: 1,
    // letter spacing as a relative unit
    letterSpacing: 0,
    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: "rgba(181, 137, 0, 0.6)",
    // terminal text color under BLOCK cursor
    cursorAccentColor: "#000",
    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: "BLOCK",
    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,
    // color of the text
    foregroundColor: "#839496",
    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: `${backgroundColor}`,
    // terminal selection color
    selectionColor: "rgba(248,28,229,0.3)",
    // border color (window, tabs)
    borderColor: "transparent",
    // custom CSS to embed in the main window
    termCSS: `
    `,
    css: `
      * {
      	text-rendering: optimizeLegibility;
        font-weight: 500;
      }
      .tabs_list {
      	border: 0;
      }
      .tabs_nav {
      	background-color: ${backgroundColor};
      }
      .tab_tab {
        color: ${foregroundColor};
        background-color: ${backgroundColor};
        border-color: ${borderColor};
      }
      .tab_tab:before {
      	border: 0;
      }
      .tab_tab.tab_active {
        border: transparent;
        font-weight: bold;
        color: #b3b3b3;
        background-color: ${backgroundColor};
      }
      .splitpane_divider {
      	background-color: #002028 !important;
      }
    `,
    workingDirectory: "",
    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: "",
    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: "",
    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: "2px 2px",
    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      lightBlack: "#586e75",
      black: "#073642",
      lightGreen: "#586e75",
      lightYellow: "#657b83",
      lightBlue: "#839496",
      lightCyan: "#93a1a1",
      white: "#eee8d5",
      lightWhite: "#fdf6e3",
      yellow: "#b58900",
      lightRed: "#cb4b16",
      red: "#dc322f",
      magenta: "#d33682",
      lightMagenta: "#6c71c4",
      blue: "#268bd2",
      cyan: "#2aa198",
      green: "#859900",
    },
    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Windows Subsystem for Linux (WSL) - previously Bash on Windows
    // - Example: `C:\\Windows\\System32\\wsl.exe`
    //
    // Git-bash on Windows
    // - Example: `C:\\Program Files\\Git\\bin\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    //
    // Cygwin
    // - Example: `C:\\cygwin64\\bin\\bash.exe`
    shell: "",
    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ["--login"],
    // for environment variables
    env: {},
    // Supported Options:
    //  1. 'SOUND' -> Enables the bell as a sound
    //  2. false: turns off the bell
    bell: false,
    // An absolute file path to a sound file on the machine.
    // bellSoundURL: '/path/to/sound/file',
    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,
    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,
    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,
    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: "vertical",
    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: true,
    // keypress required for weblink activation: [ctrl|alt|meta|shift]
    // todo: does not pick up config changes automatically, need to restart terminal :/
    webLinksActivationKey: "",
    // if `false` (without backticks and without quotes), Hyper will use ligatures provided by some fonts
    disableLigatures: true,
    // set to true to disable auto updates
    disableAutoUpdates: false,
    // set to true to enable screen reading apps (like NVDA) to read the contents of the terminal
    screenReaderMode: false,
    // set to true to preserve working directory when creating splits or tabs
    preserveCWD: true,
    // for advanced config flags please refer to https://hyper.is/#cfg
    opacity: 0.93,
    titleBarStyle: "transparent",
    transparent: true,
  },

  plugins: ["hyper-opacity"],
};
//
