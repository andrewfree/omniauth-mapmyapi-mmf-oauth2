require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class MapMyFitness < OmniAuth::Strategies::OAuth2
      option :name, "mapmyfitness"
      
      option :client_options, {
        :site => "https://oauth2-api.mapmyapi.com",
        :authorize_url => "https://www.mapmyfitness.com/v7.0/oauth2/authorize/",
        :token_url => "https://oauth2-api.mapmyapi.com/v7.0/oauth2/access_token/",
        :token_method => :post
      }

      option :token_options, { :grant_type => 'authorization_code' }

      uid { raw_info["id"].to_s }

      info { raw_info.delete("email","first_name","last_name","gender","birthday","weight","height","location").update("name" =>raw_info["display_name"],"nickname" => raw_info["username"]) }

      extra { raw_info }

      def client
        @client ||= ::OAuth2::Client.new(options.client_id, options.client_secret, deep_symbolize(options.client_options))
        @client.options[:connection_opts][:headers] =  {'Api-Key' => @client.id}
        @client
      end

      def raw_info
        @raw_info ||= access_token.get("/v7.0/user/self").parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'mapmyfitness', 'MapMyFitness'