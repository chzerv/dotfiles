# Load the output of ag in vim's quickfix list
viq() {
    nvim -q <(ag $1)
}
