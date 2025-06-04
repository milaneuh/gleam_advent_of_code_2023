import day_1/day_1
import gleeunit
import gleeunit/should

const part_2 = [
  "two1nine", "eightwothree", "abcone2threexyz", "xtwone3four",
  "4nineeightseven2", "zoneight234", "7pqrstsixteen",
]

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn part_2_test() -> Nil {
  day_1.summing_calibration_values_2(part_2)
  |> should.equal("281")
}
