# macabre_gleam_time

Fork of [gleam-lang/time](https://github.com/gleam-lang/time) (Apache-2.0) that
ports the library to [macabre](https://github.com/anomalyco/macabre)'s Python
target. The public API and all pure Gleam code are unchanged; only the two
Erlang/JavaScript externals (`system_time`, `local_time_offset_seconds`) were
replaced with the Python externals in
`src/gleam/time/time_bindings.py`.

Because the modules keep their original names, existing code keeps working with:

```gleam
import gleam/time
import gleam/time/calendar
import gleam/time/timestamp
```

## Installation

Add it to your macabre project (macabre resolves dependencies from git), along
with `macabre_stdlib`:

```toml
[dependencies]
macabre_stdlib = { git = "git@github.com:dusty-phillips/macabre_stdlib.git", ref = "main" }
macabre_gleam_time = { git = "git@github.com:dusty-phillips/macabre_gleam_time.git", ref = "main" }
```

## License

Apache-2.0, matching upstream gleam-lang/time.