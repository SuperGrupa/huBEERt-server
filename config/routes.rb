Rails.application.routes.draw do
  devise_for :users
    mount API::Base => '/api'
    mount GrapeSwaggerRails::Engine => '/apidoc'
end
