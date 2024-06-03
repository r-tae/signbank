# credo:disable-for-this-file Credo.Check.Refactor.ModuleDependencies
defmodule SignbankWeb.Router do
  use SignbankWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SignbankWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SignbankWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/about/acknowledgements", PageController, :acknowledgements
    get "/about/classes", PageController, :classes
    get "/about/community", PageController, :community
    get "/about/corpus", PageController, :corpus
    get "/about/history", PageController, :history
    get "/about/annotations", PageController, :annotations
    get "/about/dictionary", PageController, :dictionary
    get "/about/grammar", PageController, :grammar
    get "/research/vocabulary", PageController, :vocabulary

    # TODO: these routes are only slightly modified from `gen.live`, we don't want most of them
    live "/dictionary", SignLive.Index, :index
    live "/dictionary/sign/new", SignLive.Index, :new
    # live "/dictionary/sign/:id/edit", SignLive.Index, :edit
    live "/dictionary/sign/:id/edit", SignLive.Edit, :edit

    live "/dictionary/sign/:id", SignLive.BasicView, :show
    live "/dictionary/sign/:id/linguistic", SignLive.LinguisticView, :show
    live "/dictionary/sign/:id/show/edit", SignLive.Show, :edit

    # These are routes from the "recreated_signbank" project
    # live "/dictionary", SignLive.Index, :index
    # live "/dictionary/edit", SignLive.Edit, :new
    # live "/dictionary/edit/:id_gloss", SignLive.Edit, :edit
    # get "/dictionary/sign/:id_gloss", DictionaryController, :sign
    # get "/dictionary/sign/:id_gloss/detail", DictionaryController, :detail_sign
  end

  # Other scopes may use custom stacks.
  # scope "/api", SignbankWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:signbank, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SignbankWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
