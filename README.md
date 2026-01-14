# 💤 LazyVim - Configuración Personal

Configuración personalizada de [LazyVim](https://github.com/LazyVim/LazyVim) con integración de Claude Code y herramientas para desarrollo TypeScript/JavaScript.

## ✨ Características

### 🤖 Integración con IA
- **Claude Code** - Asistente de código impulsado por IA
  - Shortcuts dedicados para todas las operaciones
  - Gestión de diffs integrada
  - Soporte para múltiples modelos

### 🎨 Temas Incluidos
- Catppuccin (default)
- Tokyo Night
- Gruvbox
- Monokai

### 🛠️ Herramientas de Desarrollo
- **Formateo automático** con Prettier (TypeScript/JavaScript)
- **Linting** con ESLint
- **Soporte para Tailwind CSS**
- **LSP** configurado para múltiples lenguajes
- **Treesitter** para syntax highlighting avanzado

### 📦 Plugins Principales
- `claudecode.nvim` - Integración con Claude Code
- `conform.nvim` - Formateo de código
- `nvim-lspconfig` - Language Server Protocol
- `nvim-treesitter` - Parsing avanzado
- `telescope.nvim` - Fuzzy finder
- `gitsigns.nvim` - Git integration
- `snacks.nvim` - Terminal y utilidades

## 📋 Requisitos

### Obligatorios
- **Neovim** >= 0.9.0
- **Git**
- **A Nerd Font** (recomendado: [JetBrainsMono Nerd Font](https://www.nerdfonts.com/))

### Recomendados
- **Node.js** >= 16 (para LSP servers)
- **ripgrep** (para búsqueda con Telescope)
- **fd** (para búsqueda de archivos mejorada)
- **lazygit** (para integración git)

### Instalación de Dependencias

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install neovim git nodejs npm ripgrep fd-find
```

#### Arch Linux
```bash
sudo pacman -S neovim git nodejs npm ripgrep fd
```

#### macOS
```bash
brew install neovim git node ripgrep fd lazygit
```

## 🚀 Instalación

### Método 1: Script Automático (Recomendado)

```bash
# Clonar el repositorio
git clone https://github.com/TU_USUARIO/lazyvim-config.git ~/lazyvim-config

# Ejecutar el instalador
cd ~/lazyvim-config
./install.sh
```

El script:
- ✅ Verifica dependencias
- 📦 Crea backup de configuración existente
- 📋 Copia los archivos de configuración
- ⚠️ Te notifica de dependencias opcionales faltantes

### Método 2: Manual

```bash
# Backup de configuración existente (si existe)
mv ~/.config/nvim ~/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)

# Clonar este repositorio
git clone https://github.com/TU_USUARIO/lazyvim-config.git ~/.config/nvim

# Iniciar Neovim (instalará plugins automáticamente)
nvim
```

## 🎮 Atajos de Teclado

### Claude Code (IA)
| Atajo | Descripción |
|-------|-------------|
| `<leader>ac` | Toggle Claude panel |
| `<leader>af` | Focus Claude panel |
| `<leader>ar` | Resume Claude session |
| `<leader>aC` | Continue Claude |
| `<leader>am` | Select Claude model |
| `<leader>ab` | Add current buffer to context |
| `<leader>as` | Send selection to Claude (visual mode) |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

**Nota**: `<leader>` generalmente es la tecla `Espacio`

### Atajos Esenciales de LazyVim
| Atajo | Descripción |
|-------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Grep in files |
| `<leader>e` | Toggle file explorer |
| `<leader>gg` | Open Lazygit |
| `<leader>l` | Open Lazy plugin manager |
| `gd` | Go to definition |
| `gr` | Show references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>cf` | Format file |

## 📁 Estructura del Proyecto

```
~/.config/nvim/
├── init.lua                 # Punto de entrada
├── lazy-lock.json          # Versiones de plugins bloqueadas
├── lazyvim.json           # Extras de LazyVim habilitados
├── lua/
│   ├── config/
│   │   ├── autocmds.lua   # Auto-comandos
│   │   ├── keymaps.lua    # Mapeos de teclas personalizados
│   │   ├── lazy.lua       # Configuración de Lazy.nvim
│   │   └── options.lua    # Opciones de Neovim
│   └── plugins/
│       ├── claude.lua     # Configuración de Claude Code
│       ├── colorscheme.lua # Temas adicionales
│       ├── conform.lua    # Configuración de formateo
│       └── snack-terminal.lua # Terminal personalizada
└── stylua.toml            # Configuración de StyLua
```

## 🔧 Personalización

### Cambiar el Tema

Edita `lua/config/lazy.lua`:
```lua
install = { colorscheme = { "catppuccin", "tokyonight", "gruvbox", "monokai" } },
```

O presiona `<leader>uC` en Neovim para cambiar el tema interactivamente.

### Agregar Plugins

Crea un nuevo archivo en `lua/plugins/`:
```lua
-- lua/plugins/mi-plugin.lua
return {
  "usuario/plugin.nvim",
  opts = {
    -- configuración aquí
  },
}
```

### Modificar Atajos

Edita `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>xx", "<cmd>TuComando<cr>", { desc = "Descripción" })
```

## 🐛 Solución de Problemas

### Los plugins no se instalan
```bash
# Dentro de Neovim
:Lazy sync
```

### LSP no funciona
```bash
# Dentro de Neovim
:LspInfo
:Mason  # Para instalar LSP servers
```

### Claude Code no responde
```bash
# Verifica que Claude Code CLI esté instalado
claude --version

# Reinstala el plugin
:Lazy sync
```

### Limpiar y reinstalar
```bash
# Eliminar caché de plugins
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim

# Reiniciar Neovim
nvim
```

## 📚 Recursos

- [Documentación de LazyVim](https://lazyvim.github.io/)
- [Claude Code](https://claude.com/claude-code)
- [Neovim Docs](https://neovim.io/doc/)
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)

## 🤝 Contribuir

Si encuentras algún problema o tienes sugerencias:
1. Abre un issue
2. Crea un pull request
3. Comparte tus mejoras

## 📝 Licencia

Esta configuración está bajo la licencia Apache-2.0 (heredada de LazyVim).

## 🙏 Créditos

- [LazyVim](https://github.com/LazyVim/LazyVim) - La distribución base
- [folke](https://github.com/folke) - Creador de LazyVim
- Todos los autores de los plugins incluidos
