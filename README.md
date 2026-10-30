# Bash Cheatsheet & Learning Notes

A personal collection of Bash notes, experiments and quick reference commands, collected while learning the shell. It is untidy by design: these are working notes, not a polished tutorial.

## Layout

| Path | What's inside |
|------|---------------|
| [`CHEATSHEET.md`](CHEATSHEET.md) | Quick reference of the commands and syntax you will use most |
| [`course/`](course/) | Chapter-by-chapter notes and example scripts (chapters 01–17) |
| [`quick-commands/`](quick-commands/) | Short one-off tricks worth remembering |
| [`scripts/`](scripts/) | Small utilities, e.g. `performance.sh` |
| [`examples/`](examples/) | Standalone practice scripts |
| [`activities/`](activities/) | Exercises (e.g. building a countries/capitals directory tree) |

## Usage

Most scripts are meant to be read and run individually:

```bash
chmod +x scripts/performance.sh
./scripts/performance.sh          # one-off snapshot of memory, CPU and disk
./scripts/performance.sh true     # refresh every 5 seconds
```

`performance.sh` needs `mpstat` (from the `sysstat` package).

Some chapters create things at runtime (for example named pipes with `mkfifo` in chapter 13) and are not stored in the repo, so follow that chapter's `readme.md` to recreate them.

**Warning:** `course/17` discusses a fork bomb for educational purposes. Do not run it.

## Acknowledgements

Huge thanks to **[You Suck at Programming](https://www.youtube.com/watch?v=Sx9zG7wa4FA)** on YouTube. Most of what is here comes from following their full-length Bash scripting course. If you want to learn Bash, go watch the original and subscribe to the channel.

This repository is an independent set of study notes and is not affiliated with or endorsed by the channel.

## License

Original notes and scripts are released under the [MIT License](LICENSE).
