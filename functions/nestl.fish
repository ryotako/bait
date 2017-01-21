function nestl
  function __nestl
    read -al line
    if test (count $line) -lt 2
      string replace \* " $line[-1] " "$argv[1]"
    else
      set -l repl (echo $line[1..-2] | __nestl $argv)
      string replace \* " $repl $line[-1] " "$argv[1]"
    end
  end

  while read line
    echo $line | __nestl $argv
  end
end
