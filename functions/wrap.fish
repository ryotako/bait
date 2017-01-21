function wrap
  while read -a line
    set -l buf
    for word in $line
      set buf $buf (string replace \* $word "$argv[1]")
    end
    echo $buf
  end
end
