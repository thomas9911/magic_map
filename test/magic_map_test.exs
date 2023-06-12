defmodule MagicMapTest do
  use ExUnit.Case

  import MagicMap, only: [sigil_O: 2, sigil_o: 2]

  require MagicMap

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

  test "assignments single" do
    data = %{testing: 1, biem: 2}
    MagicMap.atom(testing) = data
    MagicMap.atom(biem) = data

    assert testing == 1
    assert biem == 2
  end

  test "assignments atom" do
    data = %{testing: 1, biem: 2, cheese: 3}
    MagicMap.atom({testing, cheese, biem}) = data

    assert testing == 1
    assert biem == 2
    assert cheese == 3
  end

  test "assignments sigil ~o" do
    data = %{testing: 1, biem: 2, cheese: 3}
    ~o{testing, cheese, biem} = data

    assert testing == 1
    assert biem == 2
    assert cheese == 3
  end

  test "assignments sigil ~O" do
    data = %{"testing" => 1, "biem" => 2, "cheese" => 3}
    ~O{testing, cheese, biem} = data

    assert testing == 1
    assert biem == 2
    assert cheese == 3
  end
end
