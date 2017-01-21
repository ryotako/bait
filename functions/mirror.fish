function mirror
  while read -a line
    echo $line[-1..1]
  end
end
