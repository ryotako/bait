function addr
  while count $argv >/dev/null; and read line
    echo $argv[1]$line
  end
end
