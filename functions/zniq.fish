function zniq
  while read -a line
    set -l buf
    for word in $line
      if not contains $word $buf
        set buf $buf $word
      end
    end
    echo $buf
  end
end
