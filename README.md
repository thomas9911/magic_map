# MagicMap

Javascript Objects at home (in Elixir)


```elixir
iex> import MagicMap, only: [sigil_O: 2, sigil_o: 2]
iex> testing = 1234
iex> demo = 9512
iex> ~o{testing, demo}
%{testing: 1234, demo: 9512}
```
