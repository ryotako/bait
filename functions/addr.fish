function addr
  if count $argv >/dev/null
    while read -l line
      echo $line$argv[1]
    end
  end
end
