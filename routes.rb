ActionController::Routing::Routes.draw do |map|
  map.resources :todos

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
