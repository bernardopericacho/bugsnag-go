# Bugsnag-Go Maze-Runner tests

These are feature tests, built on top of [maze-runner](https://github.com/bugsnag/maze-runner) - a Cucumber wrapper with convenience steps for testing Bugsnag notifiers.

In order to run these tests locally you will need a Unix shell, Docker (and docker-compose) and Bundle installed.

Configure the dependencies using:

```bash
bundle install # only needs to be done once
```

You can then run all the tests locally:

```bash
# select Go version to test using a variable (required):
GO_VERSION=1.15 bundle exec bugsnag-maze-runner
```

## Running specific features

You can run the maze-tests on a feature-by-feature basis too.

To run only a single feature you can do the following from the root of the repository.

```bash
# Only run the appversion feature
GO_VERSION=1.11 bundle exec bugsnag-maze-runner features/appversion.feature
```

Note that you will have to specify the Go version for each call.
