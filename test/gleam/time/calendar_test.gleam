import gleam/int
import gleam/order
import gleam/time/calendar
import gleam/time/duration
import gleeunit/should

pub fn month_to_string_test() {
  calendar.month_to_string(calendar.January) |> should.equal("January")
  calendar.month_to_string(calendar.December) |> should.equal("December")
}

pub fn month_to_int_test() {
  calendar.month_to_int(calendar.January) |> should.equal(1)
  calendar.month_to_int(calendar.December) |> should.equal(12)
}

pub fn month_from_int_test() {
  calendar.month_from_int(1) |> should.equal(Ok(calendar.January))
  calendar.month_from_int(12) |> should.equal(Ok(calendar.December))
  calendar.month_from_int(0) |> should.be_error()
  calendar.month_from_int(13) |> should.be_error()
}

pub fn is_leap_year_test() {
  should.be_true(calendar.is_leap_year(2000))
  should.be_true(calendar.is_leap_year(2024))
  should.be_false(calendar.is_leap_year(1900))
  should.be_false(calendar.is_leap_year(2023))
}

pub fn is_valid_date_test() {
  should.be_true(calendar.is_valid_date(calendar.Date(2024, calendar.February, 29)))
  should.be_false(calendar.is_valid_date(calendar.Date(2023, calendar.February, 29)))
  should.be_false(calendar.is_valid_date(calendar.Date(2024, calendar.April, 31)))
  should.be_true(calendar.is_valid_date(calendar.Date(2024, calendar.January, 1)))
}

pub fn is_valid_time_of_day_test() {
  should.be_true(
    calendar.is_valid_time_of_day(calendar.TimeOfDay(23, 59, 59, 999999999)),
  )
  should.be_false(calendar.is_valid_time_of_day(calendar.TimeOfDay(24, 0, 0, 0)))
  should.be_false(calendar.is_valid_time_of_day(calendar.TimeOfDay(0, 60, 0, 0)))
}

pub fn naive_date_compare_test() {
  calendar.naive_date_compare(
    calendar.Date(2024, calendar.January, 1),
    calendar.Date(2024, calendar.January, 2),
  )
  |> should.equal(order.Lt)
  calendar.naive_date_compare(
    calendar.Date(2024, calendar.January, 1),
    calendar.Date(2024, calendar.January, 1),
  )
  |> should.equal(order.Eq)
  calendar.naive_date_compare(
    calendar.Date(2024, calendar.January, 2),
    calendar.Date(2024, calendar.January, 1),
  )
  |> should.equal(order.Gt)
}

pub fn local_offset_test() {
  let hours =
    duration.to_seconds(calendar.local_offset()) / 60.0 / 60.0
  should.be_true(hours > -24.0)
  should.be_true(hours < 24.0)
}
