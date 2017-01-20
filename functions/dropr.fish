function dropr
  while read -a line
    if test "$argv[1]" -gt 0
      if test "$argv[1]" -lt (count $line)
        set -l n (math (count $line) - $argv[1])
        echo $line[1..$n]
      else
        echo
      end
    end
  end
end
