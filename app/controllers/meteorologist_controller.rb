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
    url_street="http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address

    parsed_street_data=JSON.parse(open(url_street).read)

    @latitude = parsed_street_data["results"][0]["geometry"]["location"]["lat"].to_s
    @longitude = parsed_street_data["results"][0]["geometry"]["location"]["lng"].to_s

    url_forecast="https://api.forecast.io/forecast/1c2b812f85ea7d1d663a18c5097306a2/"+@latitude+","+@longitude

    parsed_forecast_data=JSON.parse(open(url_forecast).read)

    @current_temperature = parsed_forecast_data["currently"]["temperature"]

    @current_summary = parsed_forecast_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_forecast_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_forecast_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_forecast_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
