function bait -d 'controlling records and fields given by particular separators'
    # declare variables
    set -l arg
    set -l cmd
    set -l opt_fs  ' '
    set -l opt_ifs ' '
    set -l opt_ofs ' '
    set -l opt_eor '\n'
    set -l opt_eos '\n'
    set -l opt_each 0 # 0 or 1

    set -l c addb addl addr addt comb conv crops cycle dropl dropr dupl flat
    set c $c grep mirror nestl nestr obrev perm slit stairl stairr sublist
    set c $c subset takel takelx taker takerx uniq wrap
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
                if test -n "$arg"
                    echo "bait: too many arguments" >/dev/stderr
                    return 1
                else if test (count $argv) -gt 1
                    set arg $arg (string escape -n $argv[2])
                    set -e argv[1..2]
                else
                    set -e argv[1]
                end

            case -h --help
                __bait_usage
                return

            case --fs
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_fs (string escape -n $argv[1])
                    set -e argv[1]
                end

            case --ifs
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_ifs (string escape -n $argv[1])
                    set -e argv[1]
                end

            case --ofs
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_ofs (string escape -n $argv[1])
                    set -e argv[1]
                end

            case --eor
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_eor (string escape -n $argv[1])
                    set -e argv[1]
                end

            case --eos
                set -e argv[1]
                if count $argv >/dev/null
                    set opt_eos (string escape -n $argv[1])
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
                    set arg (string escape -n $argv[1])
                    set -e argv[1]
                else
                    echo "bait: too many arguments" >/dev/stderr
                    return 1
                end
        end
    end

    # check argument value
    #
    # number is required:
    #   comb dropl dropr dupl perm takel taker
    # number is optional (default value):
    #   conv(1) flat(number of input fields) slit(number of input fields)
    # string is required:
    #   addb addl addr addt crops grep nestl nestr takelx takerx wrap
    #
    switch $cmd
        case comb dropl dropr dupl perm takel taker
            if not test "$arg" -gt 0
                printf "bait: invalid number argument '%s'\n" "$arg" >/dev/stderr
                return 1
            end
        case addb addl addr addt crops grep nestl nestr takelx takerx wrap
            if not count $arg >/dev/null
                echo "bait: argument is required" >/dev/stderr
                return 1
            end
        case conv flat slit
            # argument is optional
            if test -n "$arg"
                and not test $arg -gt 0
                printf "bait: invalid number argument '%s'\n" "$arg" >/dev/stderr
                return 1
            end
        case '*'
            if count $arg >/dev/null
                echo "bait: argument is not required" >/dev/stderr
                return 1
            end
    end

    # sub commands
    #
    # the first argument is a parameter for the subcommant
    # the rest is array of the input fields
    #

    function __bait_addb -V opt_ofs
        set -e argv[1]
        string join $opt_ofs $argv
    end

    function __bait_addl -V opt_ofs -a arg
        set -e argv[1]
        echo "$arg"(string join $opt_ofs $argv)
    end

    function __bait_addr -V opt_ofs -a arg
        set -e argv[1]
        echo (string join $opt_ofs $argv)"$arg"
    end

    function __bait_addt -V opt_ofs
        set -e argv[1]
        string join $opt_ofs $argv
    end

    function __bait_comb -V opt_ofs -a arg
        set -e argv[1]
        if test $arg -eq 1
            for field in $argv
                echo $field
            end
        else if test "$arg" -gt (count $argv)
            string join $opt_ofs $argv
        else if test "$arg" -gt 1
            set -l i $arg
            set arg (math $arg - 1)
            while test $i -le (count $argv)
                set -l i_ (math $i - 1)
                for former in (__bait_comb "$arg" $argv[1..$i_])
                    string join $opt_ofs $former $argv[$i]
                end
                set i (math $i + 1)
            end
        end
    end

    function __bait_conv -V opt_ofs -a arg
        set -e argv[1]
        if test $arg -le (count $argv)
            string join $opt_ofs $argv[1..$arg]
            set -e argv[1]
            __bait_conv $arg $argv
        end
    end

    # this command manipulate the input as an string rather than fields
    function __bait_crops -V opt_ifs -a arg
        set -e argv[1]
        set -l input (string join "$opt_ifs" $argv)
        set -l start 1
        set -l length (string length $input)
        set -l matchedecho 1110100110 | crops "1.*1"
        while test $start -le $length
            set -l i 1
            while test $i -le (math $length - $start + 1)
                set -l sub (string sub -s $start -l $i $input)
                if not contains "$sub" $matched
                    and string match -qr "^$arg\$" "$sub"

                    set matched $matched "$sub"
                    echo $sub
                end
                set i (math $i + 1)
            end
            set start (math $start + 1)
        end
    end

    # argument is not required
    function __bait_cycle -V opt_ofs
        if test (count $argv) -eq 1
            echo $argv[1]
        else
            set -l i 1
            while test $i -le (count $argv)
                string join $opt_ofs $argv
                set argv $argv[2..-1] $argv[1]
                set i (math $i + 1)
            end
        end
    end

    function __bait_dropl -V opt_ofs -a arg
        set -e argv[1]
        if test "$arg" -lt (count $argv)
            set -l i (math $arg + 1)
            string join $opt_ofs $argv[$i..-1]
       end 
    end

    function __bait_dropr -V opt_ofs -a arg
        set -e argv[1]
        if test "$arg" -lt (count $argv)
            set -l i (math - $arg - 1)
            string join $opt_ofs $argv[1..$i]
       end 
    end

    function __bait_dupl -V opt_ofs -a arg
        set -e argv[1]
        set -l record (string join $opt_ofs $argv)
        while test "$arg" -gt 0
            echo $record
            set arg (math $arg - 1)
        end
    end

    function __bait_flat -V opt_ofs -a arg
        set -e argv[1]
        if test $arg -lt (count $argv)
            string join $opt_ofs $argv[1..$arg]
            set -l i (math $arg + 1)
            set argv $argv[$i..-1]
            __bait_flat $arg $argv
        else
            string join $opt_ofs $argv
        end
    end

    function __bait_nestl -V opt_ofs -a arg
        set -e argv[1]
        if test (count $argv) -gt 1
            string replace \* "$opt_ofs"(__bait_nestl "$arg" $argv[1..-2])"$opt_ofs$argv[-1]$opt_ofs" "$arg"
        else
            string replace \* "$opt_ofs$argv[1]$opt_ofs" "$arg"
        end
    end

    function __bait_nestr -V opt_ofs -a arg
        set -e argv[1]
        if test (count $argv) -gt 1
            string replace \* "$opt_ofs$argv[1]$opt_ofs"(__bait_nestr "$arg" $argv[2..-1])"$opt_ofs" "$arg"
        else
            string replace \* "$opt_ofs$argv[1]$opt_ofs" "$arg"
        end
    end

    # argument is not required
    function __bait_mirror -V opt_ofs
        string join $opt_ofs $argv[-1..1]
    end

    # argument is not required
    function __bait_obrev -V opt_ofs
        string join $opt_ofs $argv
        string join $opt_ofs $argv[-1..1]
    end

    function __bait_perm -V opt_ofs -a arg
        set -e argv[1]
        if test $arg -eq 1
            for field in $argv
                echo $field
            end
        else if test "$arg" -gt (count $argv)
            __bait_perm (count $argv) $argv
        else if test "$arg" -gt 1
            set arg (math $arg - 1)
            set -l i 1
            while test $i -le (count $argv)
                set -l rest $argv
                set -e rest[$i]
                for latter in (__bait_perm "$arg" $rest)
                    string join $opt_ofs $argv[$i] $latter
                end
                set i (math $i + 1)
            end
        end
    end

    function __bait_slit -V opt_ofs -a arg
        set -e argv[1]
        if test $arg -gt (count $argv)
            set arg (count $argv)
        end
        set -l i 1
        set -l fst 1
        while test $i -le $arg
            set -l lst (math $fst + (count $argv) / $arg - 1)
            if test $i -le (math (count $argv) \% $arg)
                set lst (math $lst + 1)
            end
            string join $opt_ofs $argv[$fst..$lst]
            set fst (math $lst + 1)
            set i (math $i + 1)
        end

    end

    # read inputs
    # conv, flat, and slit command read whole input as default behavior
    set -l inputs
    if contains $cmd conv flat slit
        and test $opt_each -ne 1
        while read -l input
            set inputs (string join $opt_ifs $inputs $input)
        end
    else
        while read -l input
            set inputs $inputs $input
        end
    end

    # execution
    set -l output_sets
    for input in $inputs
        set -l input_fields (string split "$opt_ifs" $input)

        # set value of the optional argument
        if test -z "$arg"
            switch $cmd
                case conv
                    set arg 1
                case flat slit
                    set arg (count $input_fields)
            end
        end

        set -l outpot_records (eval __bait_$cmd $arg $input_fields)
        set output_sets $output_sets (string join "$opt_eor" $outpot_records)
    end

    # write optputs
    if test $cmd = addt
        echo -en $arg$opt_eor
    end

    echo -en (string join $opt_eos $output_sets)

    if test $cmd = addb
        echo -en $opt_eor$arg
    end

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
    echo "      crops   (crop all the patterns matching STR)"
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
    echo "      --fs  STR   field separator        (default: ' ')"
    echo "      --ifs STR   input field separator  (default: ' ')"
    echo "      --ofs STR   output field separator (default: ' ')"
    echo "      --eor STR   end of record          (default: \\n)"
    echo "      --eos STR   end of set             (default: \\n)"
    echo "      --each      manipulate input lines respectively"
    echo "                  (available for flat / conv / slit commands)"
end
