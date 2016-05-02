require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

     url="https://api.forecast.io/forecast/c28e2a4a5279db3928b559aa25127fde/#{@lat},#{@lng}"
     parseddata = JSON.parse(open(url).read)

    @current_temperature = parseddata["currently"]["temperature"]

    @current_summary = parseddata["currently"]["summary"]

    @summary_of_next_sixty_minutes = parseddata["minutely"]["summary"]

    @summary_of_next_several_hours = parseddata["hourly"]["summary"]

    @summary_of_next_several_days = parseddata["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
