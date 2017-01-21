function zniq
  while read -al line
    set -l buf
    for word in $line
      if not contains $word $buf
        set buf $buf $word
      end
    end
    echo $buf
  end
end
