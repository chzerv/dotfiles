vim.filetype.add({
    extension = {
        conf = "conf",
    },
    pattern = {
        ["main.y(a*)ml"] = "yaml.ansible",
        ["site.y(a*)ml"] = "yaml.ansible",
        ["playbook.y(a*)ml"] = "yaml.ansible",
        [".*/tasks/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/role(s*)/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/vars/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/group_vars/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/default(s*)/.*%.y(a*)ml"] = "yaml.ansible",
    },
    filename = {
        ["go.mod"] = "go",
    }
})
