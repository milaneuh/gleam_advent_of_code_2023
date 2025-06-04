import file_streams/file_stream
import file_streams/file_stream_error

pub fn read_file_to_list(file_path: String) -> Result(List(String), String) {
  case file_stream.open_read(file_path) {
    Ok(stream) -> read_lines(stream, [])
    Error(_) -> Error("No file were found :(")
  }
}

pub fn read_lines(
  file: file_stream.FileStream,
  acc: List(String),
) -> Result(List(String), String) {
  case file |> file_stream.read_line {
    Ok(line) -> read_lines(file, [line, ..acc])
    Error(file_stream_error.Eof) -> Ok(acc)
    Error(_) -> Error("Unexpected error")
  }
}
