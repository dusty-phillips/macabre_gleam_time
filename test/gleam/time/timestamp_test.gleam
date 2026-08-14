import gleam/order
import gleam/time/duration
import gleam/time/timestamp
import gleeunit/should

pub fn system_time_test() {
  let now = timestamp.system_time()
  timestamp.compare(now, timestamp.from_unix_seconds(0))
  |> should.equal(order.Gt)
}

pub fn from_unix_seconds_test() {
  let ts = timestamp.from_unix_seconds(0)
  timestamp.to_unix_seconds(ts) |> should.equal(0.0)
  let ts = timestamp.from_unix_seconds(1700000000)
  timestamp.to_unix_seconds(ts) |> should.equal(1700000000.0)
}

pub fn from_unix_seconds_and_nanoseconds_test() {
  let ts = timestamp.from_unix_seconds_and_nanoseconds(1700000000, 500000000)
  timestamp.to_unix_seconds_and_nanoseconds(ts)
  |> should.equal(#(1700000000, 500000000))
}

pub fn compare_test() {
  let early = timestamp.from_unix_seconds(100)
  let late = timestamp.from_unix_seconds(200)
  timestamp.compare(early, late) |> should.equal(order.Lt)
  timestamp.compare(early, early) |> should.equal(order.Eq)
  timestamp.compare(late, early) |> should.equal(order.Gt)
}

pub fn add_subtract_test() {
  let ts = timestamp.from_unix_seconds(100)
  let result = timestamp.add(ts, duration.seconds(50))
  timestamp.to_unix_seconds(result) |> should.equal(150.0)
  let result = timestamp.subtract(ts, duration.seconds(50))
  timestamp.to_unix_seconds(result) |> should.equal(50.0)
}

pub fn to_rfc3339_test() {
  let ts = timestamp.from_unix_seconds(1700000000)
  timestamp.to_rfc3339(ts, duration.hours(0))
  |> should.equal("2023-11-14T22:13:20Z")
}

pub fn parse_rfc3339_test() {
  let assert Ok(ts) = timestamp.parse_rfc3339("2023-11-14T22:13:20.000000000Z")
  timestamp.to_unix_seconds(ts) |> should.equal(1700000000.0)
  timestamp.parse_rfc3339("not a timestamp") |> should.be_error()
}

pub fn to_calendar_from_calendar_test() {
  let ts = timestamp.from_unix_seconds(1700000000)
  let #(date, time_of_day) = timestamp.to_calendar(ts, duration.hours(0))
  let roundtrip = timestamp.from_calendar(date, time_of_day, duration.hours(0))
  should.equal(roundtrip, ts)
}
