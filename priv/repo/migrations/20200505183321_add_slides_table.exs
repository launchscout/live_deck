defmodule LiveDeck.Repo.Migrations.AddSlidesTable do
  use Ecto.Migration

  def change do
    create table("slides") do
      add :filename, :string
      add :background_color, :string
      add :title, :string
    end
  end
end
