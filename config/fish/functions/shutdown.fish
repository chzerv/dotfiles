function shutdown --wraps='systemctl poweroff' --description 'alias shutdown systemctl poweroff'
  systemctl poweroff $argv; 
end
