# Gruntfile.js: what's in it.

> This files contains documentation about the grunt architecture
> and targets. Feel free to send a PR [here](https://github.com/DeuxHuitHuit/symphony-2-template) if there are any problems.

# Verbose mode

Most target are sensible to the `--verbose` flag.
If you need more info on a task, add the `--verbose` flag to your command.

# Targets

The default target will run most of the tasks, which is probably not what you want while working on the project.
Please use the target that matches what you want to do.

# The build does not works

Make sure you've `npm i` and re-try. Follow the rules. Repeat.

## I've changed:

### Some css

Make sure it builds and lints.

```
grunt css css-dev
```

### Some javascript

Make sure it builds and lints.

```
grunt js js-dev
```

### Some css and some javascript

Make sure it builds and lints.

```
grunt build dev
```

## I want to:

### Create and test a new build

```
grunt build push
```

### Create and test a new css bundle

```
grunt bundle
```

\*Push is free here (for now)

### Create a new release candidate

```
grunt TODO <patch|minor>
grunt build push
svn ci -m 'new RC a.b.c build x'
```

### Delete build files (locally)

Either one of:

```
grunt clean:js
grunt clean:css
grunt clean:build
```

# Tasks folder

We use `jit-grunt` to only load needed node modules.
We use the custom tasks feature to split the configuration across multiple files.
Tasks files must be name like the task name.
Custom tasks must load the normal plug-ins via our `grunt.gruntLoad` and `grunt.gruntContribLoad ` functions.
 
