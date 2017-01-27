# -h / --help option
test "bait -h"
    (bait -h) = (__bait_usage)
end

test "bait --help"
    (bait -h) = (__bait_usage)
end

test "bait -help (illegal option)"
    -z (bait -help 2> /dev/null)
end

test "bait --h (illegal option)"
    -z (bait -help 2> /dev/null)
end

# bait addb
test "echo abc | bait addb ABC"
    "abc,ABC" = (echo abc | bait addb ABC --eor ,)
end

# bait addb
test "echo abc | bait addt ABC"
    "ABC,abc" = (echo abc | bait addt ABC --eor ,)
end

# bait addl
test "echo abc | bait addl ABC"
    "ABCabc" = (echo abc | bait addl ABC)
end

# bait addr
test "echo abc | bait addr ABC"
    "abcABC" = (echo abc | bait addr ABC)
end

# bait comb
test "echo A B C D | bait comb 2"
    "A B,A C,B C,A D,B D,C D" = (echo A B C D | bait comb 2 --eor ,)
end

# bait conv
test "seq 10 | bait conv 2"
    "1 2,2 3,3 4,4 5,5 6,6 7,7 8,8 9,9 10" = (seq 10 | bait conv 2 --eor ,)
end

# bait crops
test 'echo 1110100110 | bait crops "1.*1"'
    "1001,10011,101,101001,1010011,11,1101,1101001,11010011,111,11101,11101001,111010011" = (echo 1110100110 | bait crops "1.*1" | bait slit | sort | bait flat --ofs ,)
end

# bait cycle
test "echo A B C D E | bait cycle"
    "A B C D E,B C D E A,C D E A B,D E A B C,E A B C D" = (echo A B C D E | bait cycle --eor ,)
end

# bait dropl
test "echo QBY JCG FCM PAG TPX BQG UGB | dropl 3"
    "PAG TPX BQG UGB" = (echo QBY JCG FCM PAG TPX BQG UGB | bait dropl 3)
end

# bait dropr
test "echo QBY JCG FCM PAG TPX BQG UGB | dropr 3"
    "QBY JCG FCM PAG" = (echo QBY JCG FCM PAG TPX BQG UGB | bait dropr 3)
end

# bait dupl
test "echo A B C D | bait dupl 3"
    "A B C D,A B C D,A B C D" = (echo A B C D | bait dupl 3 --eor ,)
end

# bait grep
test 'echo 1 2 3 4 5 6 7 8 9 10 | bait grep "1"'
    "1 10" = (echo 1 2 3 4 5 6 7 8 9 10 | bait grep "1")
end

# bait flat
test "seq 10 | bait flat"
    "1 2 3 4 5 6 7 8 9 10" = (seq 10 | bait flat)
end

test "seq 10 | bait flat 2"
    "1 2,3 4,5 6,7 8,9 10" = (seq 10 | bait flat 2 --eor ,)
end

# bait mirror
test "echo A B C D | bait mirror"
    "D C B A" = (echo A B C D | bait mirror)
end

# bait nestl
test 'echo aaa bbb ccc | bait nestl "<p>*</p>"'
    "<p> <p> <p> aaa </p> bbb </p> ccc </p>" = (echo aaa bbb ccc | bait nestl "<p>*</p>")
end

# bait nestr
test 'echo aaa bbb ccc | bait nestr "<p>*</p>"'
    "<p> aaa <p> bbb <p> ccc </p> </p> </p>" = (echo aaa bbb ccc | bait nestr "<p>*</p>")
end

# bait obrev
test "echo A B C D | bait obrev"
    "A B C D,D C B A" = (echo A B C D | bait obrev --eor ,)
end

# bait perm
test "echo A B C D | bait perm 2"
    "A B,A C,A D,B A,B C,B D,C A,C B,C D,D A,D B,D C" = (echo A B C D | bait perm 2 --eor ,)
end

# bait slit
test "echo A B C D | bait slit 3"
    "A B,C,D" = (echo A B C D | bait slit 3 --eor ,)
end

# bait stairl
test "echo A B C D | bait stairl"
    "A,A B,A B C,A B C D" = (echo A B C D | bait stairl --eor ,)
end

# bait stairr
test "echo A B C D | bait stairr"
    "D,C D,B C D,A B C D" = (echo A B C D | bait stairr --eor ,)
end

# bait sublist
test "echo A B C D | bait sublist"
    "A,A B,B,A B C,B C,C,A B C D,B C D,C D,D" = (echo A B C D | bait sublist --eor ,)
end

# bait subset
test "echo A B C D | bait subset"
    "A,B,C,D,A B,A C,B C,A D,B D,C D,A B C,A B D,A C D,B C D,A B C D" = (echo A B C D | bait subset --eor ,)
end

# bait takel
test "echo A B C D | bait takel 3"
    "A B C" = (echo A B C D | bait takel 3)
end

# bait takelx
test 'echo QBY JCG FCM PAG TPX BQG UGB | bait takelx "^P.*\$"'
    "QBY JCG FCM PAG" = (echo QBY JCG FCM PAG TPX BQG UGB | takelx "^P.*\$")
end
# bait taker
test "echo A B C D | bait taker 3"
    "B C D" = (echo A B C D | bait taker 3)
end

# bait takerx
test 'echo QBY JCG FCM PAG TPX BQG UGB | bait takerx "^P.*\$"'
    "PAG TPX BQG UGB" = (echo QBY JCG FCM PAG TPX BQG UGB | takerx "^P.*\$")
end

# bait wrap

# bait uniq

