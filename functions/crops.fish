function crops
  while read -l line
    set -l length (string length $line)
    set -l start 1
    set -l buf

    while test $start -le $length
      set -l i 1
      while test $i -le (math $length - $start + 1)
        set -l sub (string sub -s $start -l $i $line)
        if not contains $sub $buf; and string match -qr "^$argv[1]\$" "$sub"
          set buf $buf $sub
        end
        set i (math $i + 1)
      end
      set start (math $start + 1)
    end

    for s in $buf
      echo $s
    end
  end
end
