# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2018-11-16

Rewrite the cookbook.

### Changed
- `cronic_setup` resource is renamed to `cronic`.
- `src_dir` property (default `/opt/cronic`) is added to `cronic` resource.
- `uninstall` action now removes the directory `src_dir`.

### Removed
- the default recipe is removed.

## [1.0.0] - 2018-07-13

Create the cookbook.
