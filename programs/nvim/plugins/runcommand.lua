local input = vim.fn.input("Enter Command: ");
local output = vim.api.nvim_exec2(string.format("!%s", input), { output = true });
local buffer = vim.api.nvim_create_buf(true, false);
local lines = {};
local count = 0;
for line in string.gmatch(output.output, "([^\n]+)") do
  table.insert(lines, line);
  count = count + 1;
end
vim.api.nvim_open_win(buffer, true, {
  split = "below",
  style = "minimal",
  win = 0,
})
-- And we would rather prefer that this buffer will be destroyed when hide.
vim.api.nvim_buf_set_lines(buffer, 0, count, false, lines);
vim.api.nvim_set_option_value("modifiable", false, { buf = buffer, });
--vim.api.nvim_set_option_value("bufhidden", "delete", { buf = buffer, });
--
vim.api.nvim_create_autocmd("BufLeave", {
  buffer = buffer,
  callback = function()
    vim.api.nvim_buf_delete(buffer, { force = true, })
  end
})
