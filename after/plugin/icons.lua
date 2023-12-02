local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
    return
end

nvim_web_devicons.setup{
    override = {
        asm = {
            icon = "",
            color = "#2a2aec",
            cterm_color = "20",
            name = "asm"
        },
        S = {
            icon = "",
            color = "#2a2aec",
            cterm_color = "20",
            name = "S"
        },
        ino = {
            icon = "󰛤",
            color = "#00979c",
            name = "ino",
        },
    };
}
