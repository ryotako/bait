function dupl
  while read line
    set -l i 1
    while test $i -le "$argv[1]"
      echo $line
      set i (math $i + 1)
    end
  end
end
