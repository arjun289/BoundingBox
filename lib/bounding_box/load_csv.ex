defmodule BoundingBox.LoadCsv do

  alias BoundingBox.Store
  NimbleCSV.define(MyParser, separator: ",")

  @file_path "coordinates.csv"
  @coordinate_pair "pairs.csv"

  @coordinate_store :coordinate_store

  def create_coordinate_store() do
    @file_path
    |> File.stream!()
    |> MyParser.parse_stream
    |> Stream.map(fn [lat, lng] ->
      {String.to_float(lat) , String.to_float(lng)}
    end)
    |> Enum.each(fn x ->
        Store.put(@coordinate_store, x)
    end)
  end
end
