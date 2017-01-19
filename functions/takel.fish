function takel
  while read -a line
    if test "$argv[1]" -gt 0
      if test "$argv[1]" -gt (count $line)
        echo $line
      else
        echo $line[1..$argv[1]]
      end
    end
  end
end
