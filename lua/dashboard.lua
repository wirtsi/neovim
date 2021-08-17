local g = vim.g

g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
  -- "       ,'\`\`%.%._   ,'\`\`%.",
  -- "      :,%-%-%._:%)\,:,%._,%.:       All Glory to",
  -- "      :\`%-%-,''   :\`%.%.%.';\      the HYPNO TOAD!",
  -- "       \`,'       \`%-%-%-'  \`%.",
  -- "       /                 :",
  -- "      /                   \"",
  -- "    ,'                     :\%.___,%-%.",
  -- "   \`%.%.%.,%-%-%-'\`\`\`\`\`\`%-%.%.%._    |:       \"",
  -- "     %(                 %)   ;:    %)   \  _,%-%.",
  -- "      \`%.              %(   //          \`'    \"",
  -- "       :               \`%.//  %)      %)     , ;",
  -- "     ,%-|\`%.            _,'/       %)    %) ,' ,'",
  -- "    %(  :\`%.\`%-%.%.____%.%.=:%.%-':     %.     _,' ,'",
  -- "     \`,'\ \`\`%-%-%.%.%.%.%-%)='    \`%._,  \  ,'%) _ '\`\`%._",
  -- "  _%.%-/ _ \`%.       %(_%)      /     %)' ; / \ \\`%-%.'",
  -- " \`%-%-%(   \`%-:\`%.     \`' ___%.%.'  _,%-'   |/   \`%.%)",
  -- "     \`%-%. \`%.\`%.\`\`%-%-%-%-%-\`\`%-%-,  %.'",
  -- "       |/\`%.\\`'        ,','%); SSt",
  -- "           \`         %(/  %(/"
}

g.dashboard_custom_section = {
  a = {description = {"  Find File                 SPC f f"}, command = "Telescope find_files"},
  b = {description = {"  Recents                   SPC f o"}, command = "Telescope oldfiles"},
  c = {description = {"  Find Word                 SPC f w"}, command = "Telescope live_grep"},
  d = {description = {"洛 New File                  SPC f n"}, command = "DashboardNewFile"},
  e = {description = {"  Bookmarks                 SPC b m"}, command = "Telescope marks"},
  f = {description = {"  Load Last Session         SPC s l"}, command = "SessionLoad"},
  g = {description = {"✰  Show projects             SPC f p"}, command = "Telescope projects"}
}

g.dashboard_custom_footer = {
  "   "
}
