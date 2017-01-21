function zrep
  if test -z "$argv[1]"
    return 0
  end

  while read -a line
    set -l buf
    for word in $line
      if string match -qr $argv[1] $word
        set buf $buf $word
      end
    end
    echo $buf
  end
end
