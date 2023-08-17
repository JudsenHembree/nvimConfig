local linter = {}

function linter.setup()
    local ft = require('guard.filetype')

    ft('cpp'):fmt('clang-format')
       :lint('clang-tidy')

    -- Call setup() LAST!
    require('guard').setup({
        -- the only options for the setup function
        fmt_on_save = true,
        -- Use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = false,
    })
end

return linter
