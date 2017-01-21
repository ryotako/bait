function taker
  while read -al line
    if test "$argv[1]" -gt 0
      if test "$argv[1]" -gt (count $line)
        echo $line
      else
        set -l n -$argv[1]
        echo $line[$n..-1]
      end
    end
  end
end
