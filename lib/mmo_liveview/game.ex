defmodule MmoLiveview.Game do
  @field_size 500
  def join(id, name) when is_binary(id) and is_binary(name) do
    :random.seed()
    chara = %{name: name, x: rand(@field_size), y: rand(@field_size)}
    join_game(id)
    update_chara(id, chara)
  end

  @spec leave(binary) :: true
  def leave(id) when is_binary(id) do
    leave_game(id)
    clear_chara(id)
  end

  def list() do
    id_list() |> Enum.map(&get_chara/1)
  end

  @spec update(any, any, any, any) :: true
  def update(id, name, pos_x, pos_y) when is_binary(id) do
    chara = %{name: name, x: pos_x, y: pos_y}
    update_chara(id, chara)
  end

  def update_name(id, name) do
    %{name: _, x: pos_x, y: pos_y} = get_chara(id)
    update_chara(id, %{name: name, x: pos_x, y: pos_y})
  end

  def move(id, x, y) when is_binary(id) do
    %{name: name, x: pos_x, y: pos_y} = get_chara(id)
    update_chara(id, %{name: name, x: pos_x + x, y: pos_y + y})
  end

  defp get_chara(id), do: Stash.get(:mmo, "chara:#{id}") |> Map.put(:id, id)
  defp update_chara(id, chara), do: Stash.set(:mmo, "chara:#{id}", chara)
  defp clear_chara(id), do: Stash.delete(:mmo, "chara:#{id}")

  defp id_list, do: Stash.get(:mmo, "chara_list") || []
  defp join_game(id), do: Stash.set(:mmo, "chara_list", (id_list() ++ [id]) |> Enum.uniq())
  defp leave_game(id), do: Stash.set(:mmo, "chara_list", id_list() |> List.delete(id))

  defp rand(max), do: (:random.uniform() * max) |> trunc()
end
