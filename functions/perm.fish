function perm

  function __perm
    read -a line
    if test "$argv[1]" -eq 1
      for word in $line
        echo $word
      end
    else if test "$argv[1]" -gt 1
      set -l i 1
      while test $i -le (count $line)

        if test (count $line) -lt 2
          echo $line[$i]
        else


          set -l rest
          if test $i -eq 1
            set rest $line[2..-1]
          else if test $i -eq (count $line)
            set rest $line[1..-2]
          else
            set -l i_ (math $i - 1)
            set -l i__ (math $i + 1)
            set rest $line[1..$i_] $line[$i__..-1]
          end

          for latter in (echo $rest | __perm (math "$argv[1]" - 1))
            echo $line[$i] $latter
          end
        end

        set i (math $i + 1)
      end
    end
  end

  while read line
    echo $line | __perm "$argv[1]"
  end

end
