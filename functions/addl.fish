function addl
  while count $argv >/dev/null; and read line
    echo $line$argv[1]
  end
end
