function addb
  while read -l line
    echo $line
  end
  if count $argv >/dev/null
    echo $argv[1]
  end
end
