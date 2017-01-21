function obrev
  while read -al line
      echo "$line[1..-1]"
      echo "$line[-1..1]"
  end
end

