defmodule First do
  @moduledoc """
  Documentation for First.
  """

  @doc """
  Hello world.

  ## Examples

      iex> First.hello()
      :world

  """
  def run do
    {:ok, file} = File.read("input/01.txt")

    fuel_resoult_for_modules =
      file
      |> String.split("\n")
      |> Enum.map(fn x -> Integer.parse(x) end)
      |> Enum.drop(-1)
      |> Enum.map(fn x -> elem(x, 0) end)
      |> Enum.map(fn x -> calculate_fuel(x) end)

    total_fuel_for_modules = fuel_resoult_for_modules |> Enum.reduce(fn x, acc -> x + acc end)

    new_fuel_for_fuel =
      fuel_resoult_for_modules
      |> Enum.map(fn x -> fuel_for_fuel(x) end)

    new_fuel_total = new_fuel_for_fuel |> Enum.reduce(fn x, acc -> x + acc end)
    IO.inspect("Final resoult")
    IO.inspect(total_fuel_for_modules + new_fuel_total)

    # IO.inspect "TEST"
    # test_number = 100756
    # IO.inspect calculate_fuel(test_number) + calculate_fuel(test_number) |> fuel_for_fuel()
    # IO.inspect "Calculcate fuel"
    # IO.inspect calculate_fuel(test_number)
    # IO.inspect "Fuel for fuel"
    # IO.inspect calculate_fuel(test_number) |> fuel_for_fuel()
  end

  def calculate_fuel(mass) do
    fuel = Float.floor(mass / 3) - 2
    fuel
  end

  def fuel_for_fuel(fuel_to_acomodate) do
    fuel_for_fuel(fuel_to_acomodate, 0)
  end

  def fuel_for_fuel(fuel_to_accomodate, sum) do
    calculated_fuel = calculate_fuel(fuel_to_accomodate)

    if calculated_fuel <= 0 do
      sum
    else
      fuel_for_fuel(calculated_fuel, sum + calculated_fuel)
    end
  end
end
