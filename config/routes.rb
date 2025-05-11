Rails.application.routes.draw do
  root "home#index"

  resources :daily_numerologies, only: [:new, :create, :show]

  # PDF export for any calendar range
  get "calendar", to: "home#calendar_pdf", as: :calendar_pdf, defaults: { format: :pdf }
end


