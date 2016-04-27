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

geocoding_url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address.gsub("%20","+")
    geocoding_parsed_data = JSON.parse(open(geocoding_url).read)
    latitude = geocoding_parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = geocoding_parsed_data["results"][0]["geometry"]["location"]["lng"]

    forecast_url = "https://api.forecast.io/forecast/8ecb5c3c292fb07c022c5f685dc1b6b7/" + latitude.to_s + "," + longitude.to_s
    forecast_parsed_data = JSON.parse(open(forecast_url).read)

    temp = forecast_parsed_data["currently"]["temperature"]
    summary_current = forecast_parsed_data["currently"]["summary"]
    summary_of_next_sixty_minutes = forecast_parsed_data["minutely"]["summary"]
    summary_of_next_several_hours = forecast_parsed_data["hourly"]["summary"]
    summary_of_next_several_days = forecast_parsed_data["daily"]["summary"]

    @current_temperature = temp

    @current_summary = summary_current

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("street_to_weather.html.erb")
  end
end
