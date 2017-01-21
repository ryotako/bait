function cycle
  while read -al line
    set -l i 1
    while test $i -le (count $line)
      if test $i -eq 1
        echo $line
      else
        set -l i_ (math $i - 1)
        echo $line[$i..-1] $line[1..$i_]
      end
      set i (math $i + 1)
    end
  end
end
