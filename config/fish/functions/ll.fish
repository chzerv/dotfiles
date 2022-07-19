function ll --wraps='ls -l --color=always --group-directories-first' --description 'alias ll ls -l --color=always --group-directories-first'
  ls -l --color=always --group-directories-first $argv; 
end
