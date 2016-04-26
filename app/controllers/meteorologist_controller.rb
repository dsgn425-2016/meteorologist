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
    require 'open-uri'
    require 'JSON'
    climate_api_key = "f5905f1964bef804f860e30387ce61ec"

    map_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    parsed_map_data = JSON.parse(open(map_url).read)
    latitude = parsed_map_data["results"][0]["geometry"]["location"]["lat"].to_s
    longitude = parsed_map_data["results"][0]["geometry"]["location"]["lng"].to_s

    climate_url = "https://api.forecast.io/forecast/" + climate_api_key + "/"+latitude+","+longitude
    parsed_climate_data = JSON.parse(open(climate_url).read)

    @current_temperature = parsed_climate_data["currently"]["temperature"]

    @current_summary = parsed_climate_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_climate_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_climate_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_climate_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
