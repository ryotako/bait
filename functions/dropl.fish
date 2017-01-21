function dropl
  while read -al line
    if test "$argv[1]" -gt 0
      if test "$argv[1]" -lt (count $line)
        set -l n (math $argv[1] + 1)
        echo $line[$n..-1]
      else
        echo
      end
    end
  end
end
