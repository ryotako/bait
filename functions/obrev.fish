function obrev
  while read -a line
    if count $line >/dev/null
      set -l n (count $line)
      echo $line[1..$n]
      echo $line[$n..1]
    end
  end
end

