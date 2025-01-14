Rails.application.routes.draw do
  get "/plots", to: "plots#index"

  delete "/plots/:plot_id/plants/:id", to: "plant_plots#destroy"

  get "/gardens/:id", to: "gardens#show"
end
