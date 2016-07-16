# ok

*It's okay, I guess?*

## whatami

`ok` is a silly little tool I wrote which, like [`jsm`](https://github.com/dmrutherford/jsm), mostly exists because I **absolutely cannot be bothered** to learn how to properly set up `grunt` or `gulp` or whatever other build tool is in fashion this minute.

It allows you to quickly and easily add scripts in the root directory of a project, and execute them, without going through the faff of making them executable or adding them to your path. I mostly use it to mung together `jekyll`, `sass`, `jsm` and `browser-sync`, and to set up quick and easy deployment.

Basically, all the stuff `gulp` does that I would use, none of the stuff `gulp` does that I wouldn't use, and all of this with a fraction of the effort to configure.

Magic.

## Usage

```
$ ok
```

List any commands you've added, with an explanation of what they do.

```
$ ok {foo}
```

Carry out the `foo` command.

```
$ ok + {foo}
```

Add the `foo` command if it doesn't exist, and edit it.

```
$ ok - {foo}
```

Remove the `foo` command.

```
$ ok = {foo}
```

Explain what the `foo` command does.

## Disclaimer

Yes, the source code is meant to look like that.

## Copyright

[Boo, stealing!](http://plato.stanford.edu/entries/ayer/#7)
