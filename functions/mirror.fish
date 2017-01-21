function mirror
  while read -al line
    echo $line[-1..1]
  end
end
