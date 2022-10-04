local wezterm = require 'wezterm';

function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, maxwidth)
  local pane = tab.active_pane
  local title = basename(pane.foreground_process_name) .. " " .. (pane.pane_id + 1)

  return {
    {Text = " " .. title .. " " },
  }
end)
wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("%Y-%m-%d %H:%M:%S");

  -- Make it italic and underlined
  window:set_right_status(wezterm.format({
    {Attribute={Italic=true}},
    {Text=date},
  }));
end);

return {
  unix_domains = {
    {
      name = "unix",
    }
  },
  default_gui_startup_args = {"connect", "unix"},
  tls_clients = {
    {
      name = "lima",
      remote_address = "127.0.0.1:60022",
      bootstrap_via_ssh = "lima",
      -- serve_command = ["wsl", "wezterm-mux-server", "--daemonize"],
    }
  },
  color_scheme = "Dracula",
  font = wezterm.font("SauceCodePro Nerd Font"),
  font_size = 14,
  tab_max_width = 60,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  colors = {
    tab_bar = {
      background = "#0b0022",
      active_tab = {
        bg_color = "#2b2042",
        fg_color = "#c0c0c0",
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = "#1b1032",
        fg_color = "#808080",
      },
      inactive_tab_hover = {
        bg_color = "#3b3052",
        fg_color = "#909090",
        italic = true,
      },
      new_tab = {
        bg_color = "#1b1032",
        fg_color = "#808080",
      },
      new_tab_hover = {
        bg_color = "#3b3052",
        fg_color = "#909090",
        italic = true,
      }
    }
  },
  leader = { key = "t", mods = "CTRL" },
  keys = {
    {key="\\", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="-", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  }
}
