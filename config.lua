-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. ".luarocks/share/lua/5.1/magick/init.lua"

function LoadPluginList(plugin_table)
  for _, value in pairs(plugin_table) do
    table.insert(lvim.plugins, value)
  end
end

LoadPluginList(require("wiresurfer.ux"))
LoadPluginList(require("wiresurfer.git"))
LoadPluginList(require("wiresurfer.ai"))
LoadPluginList(require("wiresurfer.devtools"))
LoadPluginList(require("wiresurfer.md"))
LoadPluginList(require("wiresurfer.keymaps"))

