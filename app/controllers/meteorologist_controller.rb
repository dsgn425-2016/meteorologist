require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    require 'json'

    meteorologist_geo_api_url = 'http://maps.googleapis.com/maps/api/geocode/json?address='+url_safe_street_address

    meteorologist_geo_parsed_data = JSON.parse(open(meteorologist_geo_api_url).read)

    @meteorologist_lat = meteorologist_geo_parsed_data["results"][0]["geometry"]["location"]["lat"]

    @meteorologist_lng = meteorologist_geo_parsed_data["results"][0]["geometry"]["location"]["lng"]

    meteorologist_forecast_api_url = 'https://api.forecast.io/forecast/c747127dcd3682eb6ccf4c85504bdab6/'+@meteorologist_lat.to_s+','+@meteorologist_lng.to_s

    meteorologist_forecast_parsed_data = JSON.parse(open(meteorologist_forecast_api_url).read)

    @current_temperature = meteorologist_forecast_parsed_data["currently"]["temperature"]

    @current_summary = meteorologist_forecast_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = meteorologist_forecast_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = meteorologist_forecast_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = meteorologist_forecast_parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
