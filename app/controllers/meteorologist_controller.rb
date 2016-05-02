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

urlgoogle = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    parsed_datagoogle = JSON.parse(open(urlgoogle).read)

@latitude = parsed_datagoogle["results"][0]["geometry"]["location"]["lat"]
@longitude = parsed_datagoogle["results"][0]["geometry"]["location"]["lng"]

  urlforecast = "https://api.forecast.io/forecast/97e3277dc4c3a2e9ed3235234173a452/" + @latitude.to_s + "," + @longitude.to_s

parsed_dataforecast = JSON.parse(open(urlforecast).read)

    @current_temperature = parsed_dataforecast["currently"]["temperature"]

    @current_summary = parsed_dataforecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_dataforecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_dataforecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_dataforecast["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
