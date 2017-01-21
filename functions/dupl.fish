function dupl
  while read -l line
    if test "$argv[1]" -gt 0
      echo $line
      echo $line | dupl (math "$argv[1]" - 1)
    end
  end
end
