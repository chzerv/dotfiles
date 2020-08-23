# Weather forecast using https://github.com/chubin/wttr.in
function weather {
  # Handle our variables
  # If no arg is given, default to Athens
  local request curlArgs
  # curlArgs="-H \"Accept-Language: ${LANG%_*}\" --compressed -m 10"
  case "$1" in
    (-h|--help) request="https://wttr.in/:help" ;;
    (*)         request="https://wttr.in/?1n/${*:-Athens}" ;;
  esac

  # If the width is less than 125 cols, automatically switch to narrow mode
  if [[ ${COLUMNS} -lt 125 ]]; then
      request+='?n'
  fi
  
  # Finally, make the request
  # curl "${curlArgs}" "${request}" 2>/dev/null \
  curl "${request}" 2>/dev/null \
    || printf '%s\n' "[ERROR] weather: Could not connect to weather service."
}

