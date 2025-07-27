function run_cmd()
  local input = vim.fn.input("Enter Command: ");
  if input == "" then
    print("Nothing to do");
    return
  end
  local output = vim.api.nvim_exec2(string.format("!%s", input), { output = true });
  local buffer = vim.api.nvim_create_buf(true, false);
  vim.api.nvim_open_win(buffer, true, {
    split = "below",
    style = "minimal",
    win = 0,
  })
  -- And we would rather prefer that this buffer will be destroyed when hide.
  -- vim.api.nvim_buf_set_lines(buffer, 0, count, false, lines);
  vim.api.nvim_paste(output.output, true, -1);
  vim.api.nvim_set_option_value("modifiable", false, { buf = buffer, });
  --vim.api.nvim_set_option_value("bufhidden", "delete", { buf = buffer, });
  --
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buffer,
    callback = function()
      vim.api.nvim_buf_delete(buffer, { force = true, })
    end
  })
end

vim.api.nvim_create_autocmd("BufWritePost", {
  buffer = buffer, -- current buffer only
  callback = function()
    if vim.bo.filetype == "hcl" then
      vim.cmd("silent !packer fmt " .. vim.fn.expand("%:p"))
    end
    -- print("You are here!!!")
  end,
})
