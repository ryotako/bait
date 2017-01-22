function bait -d 'controlling records and fields given by particular separators'
    # declare variables
    set -l arg
    set -l cmd
    set -l opt_fs
    set -l opt_ifs
    set -l opt_ofs
    set -l opt_eor
    set -l opt_eos
    set -l opt_each 0

    set -l c addb addl addr addt comb conv crops cycle dropl dropr dupl flat
    set c $c grep mirror nestl nestr obrev perm slit stairl stairr sublist
    set c $c subset takel takelx taker takerx uniq wrap uniq
    set -l bait_commands $c

    # parse a command
    set cmd "$argv[1]"
    set -e argv[1]

    if test $cmd = -h
        or test $cmd = --help
        __bait_usage
        return
    else if not contains -- $cmd $bait_commands
        printf "bait: unknown subcommand '%s'" $cmd >/dev/stderr
        return 1
    end

    # parse an argument & options
    while count $argv >/dev/null
        switch $argv[1]
            case --
                if test -z "$arg"
                    set arg $arg "$argv[2]"
                    set -e argv[1..2]
                else
                    echo "bait: too many arguments" >/dev/stderr
                    return 1
                end

            case -h --help
                __bait_usage
                return

            case --fs
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_fs $argv[1]
                    set -e argv[1]
                end

            case --ifs
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_ifs $argv[1]
                    set -e argv[1]
                end

            case --ofs
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_ofs $argv[1]
                    set -e argv[1]
                end

            case --eor
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_eor $argv[1]
                    set -e argv[1]
                end

            case --eos
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_eos $argv[1]
                    set -e argv[1]
                end

            case --each
                set -e argv[1]
                set opt_each 1

            case -\*\?
                printf "bait: '%s' is not a valid option\n" $argv[1] >/dev/stderr
                return 1

            case \*
                if test -z "$arg"
                    set arg $argv[1]
                    set -e argv[1]
                else
                    echo "bait: too many arguments" >/dev/stderr
                    return 1
                end
        end
    end

    # set dafault values of options
    test -n "$opt_fs"
    or set opt_fs ' '

    test -n "$opt_ifs"
    or set opt_ifs $opt_fs

    test -n "$opt_ofs"
    or set opt_ofs $opt_fs

    test -n "$opt_eor"
    or set opt_eor \n

    test -n "$opt_eos"
    or set opt_eos \n

    # implementaions

    # addl
    function __bait_addl -V opt_ofs -V arg
        if test (count $arg) -gt 0
            printf "%s%s" $arg (string join $opt_ofs $argv)
        else
            return 1
        end
    end

    # addr
    function __bait_addr -V opt_ofs -V arg
        if test (count $arg) -gt 0
            printf "%s%s" (string join $opt_ofs $argv) $arg
        else
            return 1
        end
    end

    function __bait_comb -V opt_ofs -V arg
        if test (count $arg) -gt 0
            printf "%s%s" (string join $opt_ofs $argv) $arg
        else
            return 1
        end
    end

    # dupl
    function __bait_dupl -V opt_ofs -V opt_eor -V arg
        set -l record (string join $opt_ofs $argv)
        while test "$arg" -gt 1
            printf $record$opt_eor
            set arg (math $arg - 1)
        end
        if test "$arg" -gt 0
            printf $record
        else
            return 1
        end
    end


    # execute 
    if test $cmd = addt
        printf $arg
    end

    set -l i 1
    while read -l line
        if test $i -eq 1 -a $i -eq 1
            printf $opt_eos
        else
            printf $opt_eos
        end

        switch $cmd
            case addb addt
                printf (string join $opt_ofs (string split $opt_ifs $line))

            case addl
                __bait_addl (string split $opt_ifs $line)

            case addr
                __bait_addr (string split $opt_ifs $line)

            case dupl
                __bait_dupl (string split $opt_ifs $line)
        end

        or begin
            echo "Usage: bait [COMMAND] [OPTIONS] [N or STR]" >/dev/stderr
            return 1
        end

        set i (math $i + 1)
    end

    if test $cmd = addb
        print $arg
        if test $i -gt 1
            print "%s%s" $opt_eos $arg
        end
    end

    echo ""



    # echo arg "<$arg>"
    # echo opt_fs "<$opt_fs>"
    # echo opt_ifs "<$opt_ifs>"
    # echo opt_ofs "<$opt_ofs>"
    # echo opt_eor "<$opt_eor>"
    # echo opt_eos "<$opt_eos>"
    # echo opt_each "<$opt_each>"
end


function __bait_usage
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
