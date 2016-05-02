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

    url_safe_street_address="http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
        parsed_data = JSON.parse(open(url_safe_street_address).read)
        @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
        @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

        url="https://api.forecast.io/forecast/c28e2a4a5279db3928b559aa25127fde/#{@lat},#{@lng}"
        parseddataweather = JSON.parse(open(url).read)

    @current_temperature = parseddataweather["currently"]["temperature"]

    @current_summary = parseddataweather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parseddataweather["minutely"]["summary"]

    @summary_of_next_several_hours = parseddataweather["hourly"]["summary"]

    @summary_of_next_several_days = parseddataweather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
