defmodule MagicMap do
  @moduledoc """
  Documentation for `MagicMap`.
  """

  defp key_maker({key, _, nil}, func), do: func.(key)

  defp key_maker({:{}, _, args}, func) do
    # nested tuple

    Enum.map(args, &key_maker(&1, func))
  end

  defp key_maker(args, func) when tuple_size(elem(args, 0)) == 3 do
    # nested tuple

    args |> Tuple.to_list() |> Enum.map(&key_maker(&1, func))
  end

  defp value_mapper({:{}, _, args}) do
    args
  end

  defp value_mapper(args) when tuple_size(elem(args, 0)) == 3 do
    Tuple.to_list(args)
  end

  defp value_mapper(value) do
    value
  end

  defp inner(value, func) do
    key = key_maker(value, func)
    value = value |> value_mapper() |> List.wrap()

    keylist =
      key
      |> List.wrap()
      |> Enum.with_index()
      |> Enum.map(fn {key, index} -> {key, Enum.at(value, index)} end)

    {:%{}, [], keylist}
  end

  defp inner_sigil(value, func) do
    keylist =
      value
      |> String.split(~r{,\s*}, trim: true)
      |> Enum.map(&String.to_existing_atom/1)
      |> Enum.map(&{func.(&1), Macro.var(&1, nil)})

    {:%{}, [], keylist}
  end

  defmacro atom(value) do
    inner(value, & &1)
  end

  defmacro sigil_o({:<<>>, _, [value]}, _) do
    inner_sigil(value, & &1)
  end

  defmacro string(value) do
    inner(value, &to_string/1)
  end

  defmacro sigil_O({:<<>>, _, [value]}, _) do
    inner_sigil(value, &to_string/1)
  end
end
