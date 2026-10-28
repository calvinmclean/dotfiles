-- Option+F as tmux prefix

-- Tabs
rex.bind("alt+f>c", "client.tab.new")
rex.bind("alt+f>n", "client.tab.next")
rex.bind("alt+f>p", "client.tab.previous")

-- Splits
rex.bind("alt+f>shift+5", "pane.split", {
  direction = "right"
})
rex.bind("alt+f>shift+'", "pane.split", {
  direction = "down"
})

-- Pane management
rex.bind("alt+f>z", "pane.zoom")
rex.bind("alt+f>x", "pane.close")

-- Session management
rex.bind("alt+f>s", "session.switch")

-- Navigation
-- Opt+F → j: next pane
rex.bind("alt+f>j", function()
  local result, err = rex.session.focus_next_pane{}
  if err then rex.log("error", err) end
  return true
end)

-- Opt+F → k: previous pane
rex.bind("alt+f>k", function()
  local result, err = rex.session.focus_previous_pane{}
  if err then rex.log("error", err) end
  return true
end)

-- Double Option+F to send Option+F to terminal
rex.bind("alt+f>alt+f", "pane.send_key", {
  key = "alt+f"
})

-- Floating pane
rex.action{
  name = "new_floating_terminal",
  title = "New Floating Terminal",
  category = "Pane",

  run = function(ctx)
    local process = assert(rex.block.call(
      "com.superlogical.terminal",
      "process",
      { block_id = ctx.block_id }
    ))

    local cwd = (process.foreground or {}).cwd
             or (process.child or {}).cwd

    return assert(rex.session.new_layer{
      -- 60% width, 40% height
      bounds = { 0.1, 0.3, 0.6, 0.4 },
      -- 40%
      -- bounds = { 0.3, 0.3, 0.4, 0.4 },
      -- 50%
      -- bounds = { 0.25, 0.25, 0.5, 0.5 },
      -- 60%
      -- bounds = { 0.2, 0.2, 0.6, 0.6 },
      -- 80%
      -- bounds = { 0.1, 0.1, 0.8, 0.8 },
      layout = rex.layout.block{
        flavor = "com.superlogical.terminal.shell",
        options = {
          cwd = cwd,
        },
      },
      focus = true,
    })
  end,
}
rex.bind("alt+cmd+f", "new_floating_terminal")
