function addt
  if count $argv >/dev/null
    echo $argv[1]
  end
  while read -l line
    echo $line
  end
end
