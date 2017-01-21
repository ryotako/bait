function sublist
  while read -al line
    set -l lst 1
    while test $lst -le (count $line)
      set -l fst 1
      while test $fst -le $lst
        echo $line[$fst..$lst]
        set fst (math $fst + 1)
      end
      set lst (math $lst + 1)
    end
  end
end
