defmodule MagicMap do
  @moduledoc """
  Documentation for `MagicMap`.
  """

  defp key_maker({key, _, nil}, func), do: func.(key)

  defp key_maker(args, func) when tuple_size(elem(args, 0)) == 3 do
    # nested tuple

    args |> Tuple.to_list() |> Enum.map(&key_maker(&1, func))
  end

  defp inner(value, func) do
    key = key_maker(value, func)

    if is_list(key) do
      quote bind_quoted: [value: value, key: key] do
        key
        |> Enum.with_index()
        |> Map.new(fn {key, index} -> {key, elem(value, index)} end)
      end
    else
      quote do
        %{unquote(key) => unquote(value)}
      end
    end
  end

  defp inner_sigil(value, func) do
    keylist =
      String.split(value, ~r{,\s*}, trim: true)
      |> Enum.map(&String.to_existing_atom/1)
      |> Enum.map(&{func.(&1), Macro.var(&1, nil)})

    quote do
      keylist = unquote(keylist)
      Map.new(keylist)
    end
  end

  defmacro atom(value) do
    inner(value, & &1)
  end

  defmacro sigil_o({:<<>>, _, [value]}, _) do
    inner_sigil(value, & &1)
  end

  defmacro string(value) do
    IO.inspect(value)
    inner(value, &to_string/1)
  end

  defmacro sigil_O({:<<>>, _, [value]}, _) do
    inner_sigil(value, &to_string/1)
  end
end
