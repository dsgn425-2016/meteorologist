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
    url="http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    open(url)
    raw_data=open(url).read

    require 'json'
    parsed_data = JSON.parse(raw_data)

    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url_forecast = "https://api.forecast.io/forecast/adfd702b8d483a22eded276d6b168d7c/#{latitude},#{longitude}"
    open(url_forecast)
    raw_data_forecast=open(url_forecast).read

    parsed_data_forecast = JSON.parse(raw_data_forecast)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
