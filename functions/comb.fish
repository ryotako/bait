function comb

  function __comb
    set -l length $argv[1]
    set -l i $argv[1]

    read -a line
    while test $i -le (count $line)

      if test $length -le 1
        echo $line[$i]
      else
        set -l i_ (math $i - 1)
        for former in (echo $line[1..$i_] | __comb (math $argv[1] - 1))
          echo $former $line[$i]
        end
      end

      set -l i (math $i + 1)
    end
  end

  while read -a line
    if test "$argv[1]" -gt (count $line)
      echo $line | __comb (count $line)
    else if test "$argv[1]" -gt 0
      echo $line | __comb $argv[1]
    end
  end
end
