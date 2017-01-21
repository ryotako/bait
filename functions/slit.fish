function slit
	set -l buf
  while read -al line
    set buf $buf $line
  end

  # parse an argument
  set -l rows
  if test "$argv[1]" -gt 0
    set rows $argv[1]
  else
    set rows (count $buf)
  end

  set -l step (math (count $buf) / $rows)
  set -l mod (math (count $buf) \% $rows)

  set -l fst 1
  set -l loop 1
  while true
    set -l lst (math $fst + $step -1)
    if test "$loop" -le "$mod"
      set lst (math $lst + 1)
    end

    if test "$lst" -ge (count $buf)
      echo $buf[$fst..-1]
      break
    end

    echo $buf[$fst..$lst]
    set fst (math $lst + 1)
    set loop (math $loop + 1)
  end
end
