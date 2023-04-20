local status_ok, template = pcall(require, "template")
if not status_ok then
	return
end

template.setup({
    temp_dir = "~/.config/nvim/template",
    author = "Justin Kachele",
    email = "justin@kachele.com",
    project = {
      ['test'] = {
         ['lang'] = {
           ['cpp'] = {
             ['Tests'] = {
               'CMakeLists.txt',
             },
           },
         },
      },
      ['other'] =
      {
        ['default'] =
        {
          'README.md',
          '.gitignore',
        },
        ['lang'] =
        {
            ['lua'] =
            {
            -- '.stylua.toml',
            },
            ['cpp'] =
            {
              -- '.clang-format',
              'main.cpp',
              'CMakeLists.txt',
            },
            ['python'] =
            {
            'requirements.txt',
            },
        },
      },
    },
})
