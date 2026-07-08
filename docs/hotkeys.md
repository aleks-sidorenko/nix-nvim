# Hotkeys Reference

Keybinding reference for the `nix-nvim` Neovim distribution. Bindings are defined
in [`nvim/keymaps.nix`](../nvim/keymaps.nix) (global) and per-plugin under
[`nvim/plugins/`](../nvim/plugins/).

Some bindings are only active when the relevant option is enabled (e.g. AI
assistants, language toolchains). These are marked **opt-in** below.

---

## Legend

| Symbol | Meaning |
|---|---|
| `Leader` | `Space` key |
| `C-` | `Ctrl` |
| `S-` | `Shift` |
| `CR` | `Enter` |
| n / i / v / x / o / t | normal / insert / visual / visual-block / operator-pending / terminal mode |

---

## Motions & Line Navigation

| Action | Binding | Modes | Notes |
|---|---|---|---|
| Down (display line aware) | `j` / `Down` | n, x | `gj` when no count |
| Up (display line aware) | `k` / `Up` | n, x | `gk` when no count |
| Go to beginning of line | `H` | n, v | Alt: `g[` |
| Go to end of line | `L` | n, v | Alt: `g]` |
| Next paragraph | `J` | n, v | |
| Previous paragraph | `K` | n, v | |
| Go to end of file | `C-S-j` | n, v | |
| Go to beginning of file | `C-S-k` | n, v | |

### Relocated defaults

`J` and `K` are repurposed for paragraph motion, so their native actions move:

| Action | New binding | Was |
|---|---|---|
| Join lines | `gJ` | `J` |
| Keyword lookup / hover | `gh` | `K` |

---

## Windows

| Action | Binding | Modes | Notes |
|---|---|---|---|
| Focus left / down / up / right | `C-h/j/k/l` | n, t | |
| Decrease height | `C-Up` | n | |
| Increase height | `C-Down` | n | |
| Increase width | `C-Left` | n | |
| Decrease width | `C-Right` | n | |

### Window management (`Leader+w`)

| Action | Binding | Notes |
|---|---|---|
| Focus left / down / up / right | `Leader+wh/wj/wk/wl` | Mirrors `C-h/j/k/l` |
| Previous window | `Leader+wp` | |
| Close window | `Leader+wq` | |
| Split right | `Leader+w\|` | Also `Leader+\|` |
| Split below | `Leader+w-` | Also `Leader+-` |
| Maximize window | `Leader+wm` | |
| Equalize sizes | `Leader+w=` | |

---

## Buffers

| Action | Binding | Notes |
|---|---|---|
| Next buffer | `}` / `]b` | |
| Previous buffer | `{` / `[b` | |
| Move buffer right | `C-S-]` | |
| Move buffer left | `C-S-[` | |
| Go to buffer 1–9 | `Leader+1` … `Leader+9` | |

### Buffer management (`Leader+b`)

| Action | Binding |
|---|---|
| Next buffer | `Leader+b]` |
| Previous buffer | `Leader+b[` |
| Toggle pin | `Leader+bp` |
| Delete buffer | `Leader+bq` |
| Delete buffers to the left | `Leader+bl` |
| Delete other buffers | `Leader+bo` |
| Delete non-pinned buffers | `Leader+bP` |

> **Note:** `Leader+b` alone also opens the Telescope buffer picker.

---

## Tabs (`Leader+Tab`)

| Action | Binding |
|---|---|
| New tab | `Leader+Tab+n` |
| Close tab | `Leader+Tab+q` |
| Next tab | `Leader+Tab+]` |
| Previous tab | `Leader+Tab+[` |
| First tab | `Leader+Tab+f` |
| Last tab | `Leader+Tab+l` |

---

## Editing

| Action | Binding | Modes |
|---|---|---|
| Move line up | `C-S-,` | n, i, v |
| Move line down | `C-S-.` | n, i, v |
| Save file | `C-s` | i, x, n, s |

---

## Search & Jumps

| Action | Binding | Modes |
|---|---|---|
| Next search result (centered) | `n` | n, x, o |
| Previous search result (centered) | `N` | n, x, o |
| Escape & clear hlsearch | `Esc` | n, i |
| Redraw / clear hlsearch / diff update | `Leader+ur` | n |
| Jump back | `C-[` | n |
| Jump forward | `C-]` | n |

> **Note:** `C-[` is the ANSI equivalent of `Esc`. It is remapped to "jump back" in
> normal mode; `Esc` clears search highlights separately.

---

## Diagnostics

| Action | Binding |
|---|---|
| Line diagnostics | `Leader+cd` |
| Next diagnostic | `]d` |
| Previous diagnostic | `[d` |
| Next error | `]e` |
| Previous error | `[e` |
| Next warning | `]w` |
| Previous warning | `[w` |

---

## General

| Action | Binding | Modes |
|---|---|---|
| Quit all | `Leader+qq` | n |
| Inspect position (highlight groups) | `Leader+ui` | n |
| Enter normal mode (from terminal) | `Esc Esc` | t |

---

## LSP

| Action | Binding |
|---|---|
| Go to definition | `gd` |
| Go to references | `gr` |
| Go to declaration | `gD` |
| Go to implementation | `gI` |
| Type definition | `gT` |
| Hover | `gh` |
| Workspace symbol | `Leader+cw` |
| Rename | `Leader+cr` |
| Line diagnostics | `Leader+cd` |

---

## Find — Telescope (`Leader+f`, `Leader+s`)

| Action | Binding |
|---|---|
| Find project files | `Leader+Space` / `Leader+ff` |
| Search git files | `C-p` |
| Grep (root dir) | `Leader+/` / `Leader+fr` |
| Command history | `Leader+:` |
| Buffers | `Leader+b` / `Leader+fb` |
| Recent files | `Leader+fg` |
| Resume last picker | `Leader+fR` / `Leader+sR` |
| File browser | `Leader+fe` |
| File browser (current file dir) | `Leader+fE` |

### Search pickers (`Leader+s`)

| Action | Binding |
|---|---|
| Auto commands | `Leader+sa` |
| Current buffer fuzzy find | `Leader+sb` |
| Command history | `Leader+sc` |
| Commands | `Leader+sC` |
| Workspace diagnostics | `Leader+sD` |
| Document diagnostics | `Leader+sd` |
| Help pages | `Leader+sh` |
| Highlight groups | `Leader+sH` |
| Keymaps | `Leader+sk` |
| Man pages | `Leader+sM` |
| Marks | `Leader+sm` |
| Vim options | `Leader+so` |
| Colorscheme preview | `Leader+uC` |

### Git pickers (`Leader+g`)

| Action | Binding |
|---|---|
| Commits | `Leader+gc` |
| Status | `Leader+gs` |

---

## File Explorer & Panels

| Action | Binding | Notes |
|---|---|---|
| Toggle Neo-tree | `Leader+e` | |
| Toggle Undotree | `Leader+ut` | |
| Toggle Markdown preview | `Leader+mp` | |

---

## Terminal (`Leader+t`)

| Action | Binding |
|---|---|
| Toggle terminal | `Leader+t` |
| Toggle vertical terminal | `Leader+t\|` |
| Toggle horizontal terminal | `Leader+t-` |
| Toggle floating terminal | `Leader+tf` |

---

## Git

| Action | Binding |
|---|---|
| LazyGit (root dir) | `Leader+gg` |

---

## Completion — nvim-cmp (insert mode)

| Action | Binding |
|---|---|
| Select next item | `C-Tab` / `C-j` |
| Select previous item | `C-k` |
| Trigger completion | `C-Space` |
| Confirm (select) | `C-CR` |
| Confirm (replace) | `S-CR` |
| Abort | `C-e` |
| Scroll docs up | `C-b` |
| Scroll docs down | `C-f` |

---

## Treesitter Text Objects

### Select (visual / operator-pending)

| Text object | Outer | Inner |
|---|---|---|
| Parameter | `aa` | `ia` |
| Function | `af` | `if` |
| Class | `ac` | `ic` |
| Conditional | `ai` | `ii` |
| Loop | `al` | `il` |
| Comment | `at` | — |

### Move

| Action | Binding |
|---|---|
| Next function start | `]m` |
| Next function end | `]M` |
| Previous function start | `[m` |
| Previous function end | `[M` |
| Next class start | `]]` |
| Next class end | `][` |
| Previous class start | `[[` |
| Previous class end | `[]` |

### Swap

| Action | Binding |
|---|---|
| Swap parameter with next | `Leader+a` |
| Swap parameter with previous | `Leader+A` |

---

## AI Assistants (opt-in)

### Claude Code (`ai.claude-code.enable`)

| Action | Binding | Modes |
|---|---|---|
| Toggle Claude window | `C-;` | n, t |
| Toggle Claude | `Leader+act` | |
| Continue Claude | `Leader+acc` | |
| Resume Claude | `Leader+acr` | |
| Verbose Claude | `Leader+acv` | |

### Copilot Chat (`ai.copilot.enable`) — `Leader+aC`

| Action | Binding |
|---|---|
| Open chat | `Leader+aCo` |
| Toggle chat window | `Leader+aCt` |
| Close chat | `Leader+aCc` |
| Quick chat (prompt) | `Leader+aCq` |
| Explain code | `Leader+aCe` |
| Review code | `Leader+aCR` |
| Generate tests | `Leader+aCT` |
| Add documentation | `Leader+aCd` |
| Select prompt | `Leader+aCP` |
| List agents | `Leader+aCa` |
| List models | `Leader+aCm` |
| Load chat history | `Leader+aCl` |
| Save chat | `Leader+aCS` |
| Reset chat | `Leader+aCr` |
| Stop chat | `Leader+aCs` |

---

## Language-Specific (opt-in)

### Haskell (`development.haskell.enable`) — `Leader+h`

| Action | Binding |
|---|---|
| Hover | `Leader+hh` |
| Hoogle signature search | `Leader+hs` |
| Toggle REPL | `Leader+hr` |
| Toggle REPL for current file | `Leader+hf` |
| Quit REPL | `Leader+hq` |
