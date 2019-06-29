defmodule MmoLiveview.Repo do
  use Ecto.Repo,
    otp_app: :mmo_liveview,
    adapter: Ecto.Adapters.Postgres
end
