function stairl
  while read -a line
    set -l i 1
    while test $i -le (count $line)
      echo $line[1..$i]
      set i (math $i + 1)
    end
  end
end
