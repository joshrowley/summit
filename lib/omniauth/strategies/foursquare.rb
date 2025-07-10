puts ">>> Loaded custom OmniAuth::Strategies::Foursquare"
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Foursquare < OmniAuth::Strategies::OAuth2
      option :name, 'foursquare'
      option :client_options, {
        site: 'https://foursquare.com',
        authorize_url: 'https://foursquare.com/oauth2/authenticate',
        token_url: 'https://foursquare.com/oauth2/access_token'
      }
      option :authorize_options, [:redirect_uri]

      uid { raw_info['id'] }

      info do
        {
          firstName: raw_info['firstName'],
          lastName: raw_info['lastName'],
          photo: raw_info['photo']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.foursquare.com/v2/users/self', params: {
          v: '20230101'
        }).parsed['response']['user']
      end
    end
  end
end 