function flat --description 'print whole the inputs'
	set -l buf
  set -l i 0

	while read line
    set buf $buf $line

    set i (math $i+1)
    if test "$i" -eq "$argv[1]"
      echo $buf
      set buf 
      set i 0
    end
  end
  echo $buf
end
