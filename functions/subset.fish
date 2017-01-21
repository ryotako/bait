function subset

  function __subset
    set -l length $argv[1]
    set -l i $argv[1]

    read -al line
    while test $i -le (count $line)

      if test $length -le 1
        echo $line[$i]
      else
        set -l i_ (math $i - 1)
        for former in (echo $line[1..$i_] | __subset (math $argv[1] - 1))
          echo $former $line[$i]
        end
      end

      set -l i (math $i + 1)
    end
  end

  while read -al line
    set -l i 1
    while test $i -le (count $line)
      echo $line | __subset $i
      set i (math $i + 1)
    end
  end
end
