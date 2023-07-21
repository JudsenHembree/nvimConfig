local clip = {}
local vim = vim
local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
    return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

function clip.setup()
    vim.g.clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
    }

    vim.keymap.set('n', '<leader>c', '"+y')
    vim.keymap.set('n', '<leader>cc', '"+yy')
end

return clip
