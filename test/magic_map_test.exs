defmodule MagicMapTest do
  use ExUnit.Case
  require MagicMap

  import MagicMap, only: [sigil_O: 2, sigil_o: 2]

  test "atom" do
    testing = 1234
    assert %{testing: 1234} = MagicMap.atom(testing)
  end

  test "string" do
    testing = 1234
    assert %{"testing" => 1234} = MagicMap.string(testing)
  end

  test "multiple atom" do
    testing = 1234
    biem = 9512
    assert %{testing: 1234, biem: 9512} = MagicMap.atom({testing, biem})
  end

  test "multiple string" do
    testing = 1234
    biem = 9512
    assert %{"testing" => 1234, "biem" => 9512} = MagicMap.string({testing, biem})
  end

  test "sigil ~O" do
    testing = 1234
    biem = 9512
    assert %{"testing" => 1234, "biem" => 9512} = ~O{testing, biem}
  end

  test "sigil ~o" do
    testing = 1234
    biem = 9512
    assert %{testing: 1234, biem: 9512} = ~o{testing, biem}
  end
end
