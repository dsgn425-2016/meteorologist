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
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    parsed_data = JSON.parse(open(url).read)

    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.forecast.io/forecast/1d437dd48b71586534a52478930e5271/#{latitude},#{longitude}"

    weather_data = JSON.parse(open(weather_url).read)

    @current_temperature = weather_data["currently"]["temperature"]

    @current_summary = weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = weather_data["hourly"]["summary"]

    @summary_of_next_several_days = weather_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
