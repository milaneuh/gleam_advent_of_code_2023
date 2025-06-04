import file_streams/file_stream
import file_streams/file_stream_error
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils/file_reader

pub fn main() -> Nil {
  case file_reader.read_file_to_list("src/day_1/input.txt") {
    Ok(lines) -> summing_calibration_values(lines)
    Error(message) -> io.print(message)
  }
}

pub fn summing_calibration_values(lines: List(String)) -> Nil {
  list.map(lines, fn(line) {
    let first_number =
      line
      |> string.split("")
      |> list.find(fn(letter) { int.parse(letter) |> result.is_ok })
      |> result.unwrap("0")
    let last_number =
      line
      |> string.split("")
      |> list.reverse
      |> list.find(fn(letter) { int.parse(letter) |> result.is_ok })
      |> result.unwrap("0")

    first_number
    |> string.append(last_number)
    |> int.parse
    |> result.unwrap(0)
  })
  |> list.reduce(fn(acc, x) { acc + x })
  |> result.map(fn(x) { x |> int.to_string })
  |> result.unwrap("0")
  |> io.println
}
