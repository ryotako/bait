function takerx
  while read -a line
    set -l buf
    set -l matched 0
    if test -z "$argv[1]"
      return 0
    end
    
    for word in $line[-1..1]
      set buf $word $buf
      if string match -qr "$argv[1]" $word
        set matched 1
        break
      end
    end
    if test $matched -eq 1
      echo $buf
    else
      echo
    end
  end
end

