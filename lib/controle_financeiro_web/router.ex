defmodule ControleFinanceiroWeb.Router do
  use ControleFinanceiroWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ControleFinanceiroWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ControleFinanceiroWeb.Auth.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
  end
  scope "/", ControleFinanceiroWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", ControleFinanceiroWeb do
   pipe_through [:api, :auth]
   resources "/users", UserController, except: [:new, :edit] do
     get "/transactions", UserController, :transactions
     get "/tags", UserController, :tags
   end
   resources "/transactions", TransactionController, except: [:new, :edit]
   resources "/tags", TagController, except: [:new, :edit]
   resources "/transactions_tags", TransactionsTagController, except: [:new, :edit]
  end

  scope "/api", ControleFinanceiroWeb do
    pipe_through :api
    post "/auth/login", AuthController, :login
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:controle_financeiro, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ControleFinanceiroWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
