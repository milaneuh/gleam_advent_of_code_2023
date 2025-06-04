import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils/file_reader

pub type Number {
  Number(spelled_value: String, raw_value: String)
}

pub const numbers: List(Number) = [
  Number("one", "1"),
  Number("two", "2"),
  Number("three", "3"),
  Number("four", "4"),
  Number("five", "5"),
  Number("six", "6"),
  Number("seven", "7"),
  Number("eight", "8"),
  Number("nine", "9"),
]

pub fn main() -> Nil {
  case file_reader.read_file_to_list("src/day_1/input.txt") {
    Ok(lines) -> {
      io.println("Part One : ")
      summing_calibration_values(lines)
      io.println("Part Two : ")
      summing_calibration_values_2(lines)
      |> io.println
    }
    Error(message) -> io.print(message)
  }
}

pub fn summing_calibration_values_2(lines: List(String)) -> String {
  lines
  |> list.map(fn(line) {
    let num =
      extract_numbers(remplace_numbers(numbers, line) |> string.split(""), "")
    num
    |> string.first
    |> result.unwrap("")
    |> string.append(string.last(num) |> result.unwrap(""))
    |> int.parse
    |> result.unwrap(0)
  })
  |> list.reduce(fn(acc, x) { acc + x })
  |> result.map(fn(x) { x |> int.to_string })
  |> result.unwrap("0")
}

pub fn remplace_numbers(numbers: List(Number), line: String) -> String {
  case numbers {
    [number, ..rest] ->
      remplace_numbers(
        rest,
        line
          |> string.replace(
            number.spelled_value,
            number.spelled_value
              |> string.append(number.raw_value)
              |> string.append(number.spelled_value),
          ),
      )
    [] -> line
  }
}

pub fn extract_numbers(line: List(String), acc: String) -> String {
  case line {
    [first, ..rest] -> {
      case int.parse(first) {
        Ok(_value) -> extract_numbers(rest, acc |> string.append(first))
        Error(_) -> extract_numbers(rest, acc)
      }
    }
    [] -> acc
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
