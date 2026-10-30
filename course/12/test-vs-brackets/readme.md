# Brackets vs. Test
help '[[' # keyword
help '[' # builtin
help test # builtinto bash and bin/test


<!-- because its a keyword, its not as strict so we dont need to "", but do it -->
> run 00
> run 01

[ -f foo.txt ] ; echo $?
which '['
/bin/[ -f foo.txt ] ; echo $?

<!-- [[ can do everything [ and test can -->