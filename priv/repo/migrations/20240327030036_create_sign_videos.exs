defmodule Signbank.Repo.Migrations.CreateSignVideos do
  use Ecto.Migration

  def change do
    create table(:sign_videos) do
      add :url, :string

      add :sign_id,
          references(:signs, on_delete: :nothing)

      timestamps()
    end

    alter table(:signs) do
      # It's easier if this isn't a foreign key, otherwise there's a circular reference
      add :active_video_id, :id, null: true
    end
  end
end
