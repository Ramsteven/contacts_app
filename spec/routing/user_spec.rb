require 'rails_helper'

RSpec.describe '/users routes' do
  it 'routes from devise/sessions' do
    aggregate_failures do
      expect(get '/users/sign_in').to route_to('devise/sessions#new')
      expect(post '/users/sign_in').to route_to('devise/sessions#create')
    end
  end

  it 'routes from devise/sessions' do
    expect(delete '/users/sign_out').to route_to('devise/sessions#destroy')
  end

  it 'routes from devise/passwords' do
    aggregate_failures do
      expect(get '/users/password/new').to route_to('devise/passwords#new')
      expect(get '/users/password/edit').to route_to('devise/passwords#edit')
      expect(patch '/users/password').to route_to('devise/passwords#update')
      expect(put '/users/password').to route_to('devise/passwords#update')
      expect(post '/users/password').to route_to('devise/passwords#create')
    end
  end

it 'routes from devise/registrations' do
    aggregate_failures do
      expect(get '/users/cancel').to route_to('devise/registrations#cancel')
      expect(get '/users/sign_up').to route_to('devise/registrations#new')
      expect(get '/users/edit').to route_to('devise/registrations#edit')
      expect(patch '/users').to route_to('devise/registrations#update')
      expect(put '/users').to route_to('devise/registrations#update')
      expect(delete '/users').to route_to('devise/registrations#destroy')
      expect(post '/users').to route_to('devise/registrations#create')
    end
  end
end 
