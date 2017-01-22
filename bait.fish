function bait -d 'controlling records and fields given by particular separators'

    switch "$argv[1]"
        case -h --help
            __bait_help
    end

end

function __bait_help
    echo "Usage: bait [COMMAND] [OPTIONS] [N or STR]"
    echo
    echo "where COMMAND is one of:"
    echo "      addb    (add STR to the bottom)"
    echo "      addl    (add STR to the left side)"
    echo "      addr    (add STR to the right side)"
    echo "      addt    (add STR to the top)"
    echo "      comb    (generate combinations of N of the fields)"
    echo "      conv    (convolute with rectangular function of width N)"
    echo "      crops   (crop all the patterns which matches STR)"
    echo "      cycle   (generate all the circulated patterns)"
    echo "      dropl   (remove the first N fields)"
    echo "      dropr   (remove the last N field)"
    echo "      dupl    (duplicate to N lines)"
    echo "      flat    (print all inputs on one line or N fields per line)"
    echo "      grep    (extract fields matching regular expression STR)"
    echo "      mirror  (reverse the order of the field)"
    echo "      nestl   (nest the fields with STR regarding * as a placeholder)"
    echo "      nestr   (similar to nestl but the last field becomes deepest)"
    echo "      obrev   (Show given line and reversed line)"
    echo "      perm    (generate permutations of N of files)"
    echo "      slit    (divide the inputs into N of lines)"
    echo "      stairl  (generate sublist matching the left side on the input)"
    echo "      stairr  (generate sublist matching the right side on the input)"
    echo "      sublist (generate sublist)"
    echo "      subset  (generate subsets)"
    echo "      takel   (print the first N of the fields)"
    echo "      takelx  (print fields to the first from the fields matching STR)"
    echo "      taker   (print the last N of the fields)"
    echo "      takerx  (print fields to the first from the fields matching STR)"
    echo "      uniq    (merge duplicated fields)"
    echo "      wrap    (replace * in STR with the each fields)"
    echo
    echo "where OPTIONS are some of:"
    echo "      --fs STR   field separator (default: ' ')"
    echo "      --ifs STR   field separator (default: ' ')"
    echo "      --ofs STR   field separator (default: ' ')"
    echo "      --eor STR   end of record   (default: \\n)"
    echo "      --eos STR   end of set      (default: \\n)"
    echo "      --each      manipulate input lines respectively"
    echo "                  available for flat / conv / slit commands"
end
