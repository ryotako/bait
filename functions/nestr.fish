function nestr
  function __nestr
    read -al line
    if test (count $line) -lt 2
      string replace \* " $line[1] " "$argv[1]"
    else
      set -l repl (echo $line[2..-1] | __nestr $argv)
      string replace \* " $line[1] $repl " "$argv[1]"
    end
  end

  while read -l line
    echo $line | __nestr $argv
  end
end
