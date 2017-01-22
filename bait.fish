function bait -d 'controlling records and fields given by particular separators'
    # declare variables
    set -l arg
    set -l opt_fs
    set -l opt_ifs
    set -l opt_ofs
    set -l opt_eor
    set -l opt_eos
    set -l opt_each 0

    # parse arguments
    while count $argv > /dev/null
        switch $argv[1]
            case --
                set arg $arg $argv[2]
                set -e argv[1..2]

            case -h --help
                __bait_help
                return

            case --fs
                set -e argv[1]
                if count $argv > /dev/null
                    set opt_fs $argv[1]
                    set -e $argv[1]
                end

            case --ifs
                set -e argv[1]
                if count $argv > /dev/null
                    set opt_ifs $argv[1]
                    set -e $argv[1]
                end

            case --ofs
                set -e argv[1]
                if count $argv > /dev/null
                    set opt_ofs $argv[1]
                    set -e $argv[1]
                end

            case --eor
                set -e argv[1]
                if count $argv > /dev/null
                    set opt_eor $argv[1]
                    set -e $argv[1]
                end

            case --eos
                set -e argv[1]
                if count $argv > /dev/null
                    set opt_eos $argv[1]
                    set -e $argv[1]
                end

            case --each
                set -e argv[1]
                set opt_each 1

            case -\*\?
                printf "bait: '%s' is not a valid option\n" $argv[1] >/dev/stderr
                return 1

            case \*
                if test -z $arg
                    set arg $argv[1]
                    set -e argv[1]
                else
                    echo "bait: too many arguments" >/dev/stderr
                    return 1
                end
        end
    end

    # set dafault values of options
    if test -z opt_fs
        set opt_fs ' '
    end

    if test -z opt_ifs
        set opt_if tests $opt_fs
    end

    if test -z opt_ofs
        set opt_ofs $opt_fs
    end

    if test -z opt_eor
        set opt_eor \n
    end

    if test -z opt_eos
        set opt_eos \n
    end

    printf "ARG: %s\n" $argv[1]
    echo opt_fs   $opt_fs
    echo opt_ifs  $opt_ifs
    echo opt_ofs  $opt_ofs
    echo opt_eor  $opt_eor
    echo opt_eos  $opt_eos
    echo opt_each $opt_each
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
