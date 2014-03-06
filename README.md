# OmniAuth MapMyAPI(MapMyFitness) OAuth2

This gem contains the strategy for OmniAuth using OAuth2 for MapMyAPI, MapMyFitness specifically. It would only need to be changed slightly for work with the other MapMy____


#### Setting Environment Variables for OmniAuth

Once you have those ENV variables set, you can check them from IRB:

```plain
Set two values in your application.yml for development,staging,production.
ENV["MAPMYFITNESS_API_KEY"]
ENV["MAPMYFITNESS_APP_SECRET"]
```

### Create an Initializer

Create a `config/initializers/omniauth.rb` with the following:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
provider :mapmyfitness, ENV["MAPMYFITNESS_API_KEY"], ENV["MAPMYFITNESS_APP_SECRET"]
end
```

**NOTE**: This is work in progress