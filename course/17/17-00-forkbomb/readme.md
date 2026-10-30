# Fork Bomb

`bomb.txt` holds the famous one-liner:

```
:(){ :|:& };:
```

## Un-minified

```bash
:() {            # define a function named ':'
    : | : &      # call itself twice, piped together, in the background
}
:                # call it
```

Each call starts two more calls, which each start two more (see `diagram.txt`). The number of processes doubles forever until the process table is full and the system cannot start anything else.

It is not specific to bash: any language that can spawn processes can do it.

## A safe, bounded version

`step-bomb` is the same idea, but it stops at depth 6, so it only creates 2^6 = 64 processes:

```bash
./step-bomb 2>&1 | sort | awk '{print $1}' | uniq -c
```

The output shows how many processes exist at each depth: 1, 2, 4, 8, ...

## Defence

Limit the number of processes per user:

```bash
ulimit -u            # show the current limit
ulimit -u 200        # lower it for this shell
```

Permanent limits live in `/etc/security/limits.conf` (`nproc`).
