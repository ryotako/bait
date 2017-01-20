function stairr
  while read -a line
    set -l i -1
    while test (math 0 - $i) -le (count $line)
      echo $line[$i..-1]
      set i (math $i - 1)
    end
  end
end
