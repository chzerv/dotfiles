vim.filetype.add({
    extension = {
        conf = "conf",
    },
    pattern = {
        ["main.y(a*)ml"] = "yaml.ansible",
        ["playbook.y(a*)ml"] = "yaml.ansible",
        [".*/tasks/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/roles/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/role/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/vars/.*%.y(a*)ml"] = "yaml.ansible",
        [".*/defaults/.*%.y(a*)ml"] = "yaml.ansible",
    }
})
