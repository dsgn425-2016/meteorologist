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
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    raw_data = open(url).read
    require 'json'
    JSON.parse(raw_data)
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]

    @latitude = results[0]["geometry"]["location"]["lat"]
    @longitude = results[0]["geometry"]["location"]["lng"]

    url_2 = "https://api.forecast.io/forecast/45f018355746d406f96f9fc9d2342617/" + @latitude.to_s + "," + @longitude.to_s

    raw_data_2 = open(url_2).read
    require 'json'
    JSON.parse(raw_data_2)
    parsed_data = JSON.parse(raw_data_2)
    currently = parsed_data["currently"]
    minutely = parsed_data["minutely"]
    hourly = parsed_data["hourly"]
    daily = parsed_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("street_to_weather.html.erb")
  end
end
