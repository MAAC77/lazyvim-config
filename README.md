# LazyVim - Configuracion Personal

Configuracion personalizada de [LazyVim](https://github.com/LazyVim/LazyVim).

## Requisitos

- **Neovim** >= 0.9.0
- **Git**
- **Nerd Font** (recomendado: [JetBrainsMono Nerd Font](https://www.nerdfonts.com/))

## Instalacion

### Script Automatico (Recomendado)

```bash
git clone https://github.com/TU_USUARIO/lazyvim-config.git ~/lazyvim-config
cd ~/lazyvim-config
./install.sh
```

El script:
- Instala Neovim si no esta instalado
- Instala dependencias necesarias (ripgrep, fd, node)
- Crea backup de configuracion existente
- Copia los archivos de configuracion

### Manual

```bash
# Backup de configuracion existente (si existe)
mv ~/.config/nvim ~/.config/nvim.backup-$(date +%Y%m%d-%H%M%S)

# Clonar este repositorio
git clone https://github.com/TU_USUARIO/lazyvim-config.git ~/.config/nvim

# Iniciar Neovim (instalara plugins automaticamente)
nvim
```

## Estructura del Proyecto

```
~/.config/nvim/
├── init.lua                 # Punto de entrada
├── lazy-lock.json          # Versiones de plugins bloqueadas
├── lazyvim.json           # Extras de LazyVim habilitados
├── lua/
│   ├── config/
│   │   ├── autocmds.lua   # Auto-comandos
│   │   ├── keymaps.lua    # Mapeos de teclas personalizados
│   │   ├── lazy.lua       # Configuracion de Lazy.nvim
│   │   └── options.lua    # Opciones de Neovim
│   └── plugins/           # Plugins personalizados
└── stylua.toml            # Configuracion de StyLua
```

## Personalizacion

### Cambiar el Tema

Presiona `<leader>uC` en Neovim para cambiar el tema interactivamente.

### Agregar Plugins

Crea un nuevo archivo en `lua/plugins/`:
```lua
-- lua/plugins/mi-plugin.lua
return {
  "usuario/plugin.nvim",
  opts = {
    -- configuracion aqui
  },
}
```

### Modificar Atajos

Edita `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>xx", "<cmd>TuComando<cr>", { desc = "Descripcion" })
```

## Solucion de Problemas

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

### Limpiar y reinstalar
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
nvim
```

## Recursos

- [Documentacion de LazyVim](https://lazyvim.github.io/)
- [Neovim Docs](https://neovim.io/doc/)

## Licencia

Apache-2.0

