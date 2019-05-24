defmodule IslandsEngine.Coordinate do
  alias __MODULE__

  @enforce_keys [:row, :column]
  defstruct [:row, :column]

  @board_range 1..10

  def new(row, column) when row in @board_range and column in @board_range do
    {:ok, %Coordinate{row: row, column: column}}
  end

  def new(_row, _column), do: {:error, :invalid_coordinate}
end
