function l --wraps='ls --color=always --group-directories-first' --description 'alias l ls --color=always --group-directories-first'
  ls --color=always --group-directories-first $argv; 
end
