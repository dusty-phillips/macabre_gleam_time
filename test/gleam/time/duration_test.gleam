import gleam/order
import gleam/time/duration
import gleeunit/should

pub fn seconds_test() {
  duration.seconds(5) |> duration.to_seconds |> should.equal(5.0)
  duration.seconds(-5) |> duration.to_seconds |> should.equal(-5.0)
}

pub fn milliseconds_test() {
  duration.milliseconds(1500) |> duration.to_seconds |> should.equal(1.5)
  duration.milliseconds(1500) |> duration.to_milliseconds |> should.equal(1500)
}

pub fn minutes_hours_test() {
  duration.minutes(2) |> duration.to_seconds |> should.equal(120.0)
  duration.hours(2) |> duration.to_seconds |> should.equal(7200.0)
}

pub fn add_test() {
  let result = duration.add(duration.seconds(10), duration.seconds(5))
  duration.to_seconds(result) |> should.equal(15.0)
  let result = duration.add(duration.seconds(10), duration.seconds(-15))
  duration.to_seconds(result) |> should.equal(-5.0)
}

pub fn difference_test() {
  let result = duration.difference(duration.seconds(3), duration.seconds(10))
  duration.to_seconds(result) |> should.equal(7.0)
}

pub fn compare_test() {
  duration.compare(duration.seconds(5), duration.seconds(5))
  |> should.equal(order.Eq)
  duration.compare(duration.seconds(4), duration.seconds(5))
  |> should.equal(order.Lt)
  duration.compare(duration.seconds(6), duration.seconds(5))
  |> should.equal(order.Gt)
}

pub fn to_iso8601_string_test() {
  duration.to_iso8601_string(duration.seconds(90))
  |> should.equal("PT1M30S")
  duration.to_iso8601_string(duration.hours(2))
  |> should.equal("PT2H")
}

pub fn approximate_test() {
  duration.approximate(duration.hours(2)) |> should.equal(#(2, duration.Hour))
  duration.approximate(duration.seconds(90))
  |> should.equal(#(1, duration.Minute))
}
