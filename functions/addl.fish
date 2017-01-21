function addl
  if count $argv >/dev/null
    while read -l line
      echo $argv[1]$line
    end
  end
end
