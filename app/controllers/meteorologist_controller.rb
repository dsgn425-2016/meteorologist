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

    url_location = "http://maps.googleapis.com/maps/api/geocode/json?address=" + "#{url_safe_street_address}"
    parsed_data = JSON.parse(open(url_location).read)

    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url_forecast = "https://api.forecast.io/forecast/4c161d79ae009ea2445d7191e4a6f2cc/" + @lat.to_s + "," + @lng.to_s
    parsed_data_forecast = JSON.parse(open(url_forecast).read)


    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
