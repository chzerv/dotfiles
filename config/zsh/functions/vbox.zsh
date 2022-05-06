# mode: shell-script
# sh-basic-offset: 4

function vbox() {
    while getopts "s:p:r:k:l" option; do
        case "${option}" in
            s) VBoxManage startvm ${OPTARG} --type headless ;;
            p) VBoxManage controlvm ${OPTARG} pause --type headless ;;
            r) VBoxManage controlvm ${OPTARG} resume --type headless ;;
            k) VBoxManage controlvm ${OPTARG} poweroff --type headless ;;
            l) VBoxManage list vms ;;
        esac
    done

    if [ -z "$*" ]; then
        echo "Usage: \n"
        echo "\t vbox option <vm_name>\n"
        echo "Options: \n"
        echo "\t -s, start the specified VM\n"
        echo "\t -p, pause the specified VM\n"
        echo "\t -r, resume the specified VM\n"
        echo "\t -k, kill (power-off) the specified VM\n"
        echo "\t -l, list available VMs\n"
    fi

}
