function conv --description 'print the inputs like the convolution'
	set -l buf
  while read -a line
    set buf $buf $line
  end

  # parse an argument
  set -l step
  if test "$argv[1]" -gt 1
    set step $argv[1]
  else
    set step 1
  end
  
  set -l total (math (count $buf) - $step + 1)
  set -l fst 1

  while test "$fst" -le "$total"
    set lst (math $fst + $step -1)
    echo $buf[$fst..$lst]
    set fst (math $fst + 1)
  end
end
