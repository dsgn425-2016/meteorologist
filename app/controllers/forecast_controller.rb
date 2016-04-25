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

    weather_url = "https://api.forecast.io/forecast/1d437dd48b71586534a52478930e5271/#{@lat},#{@lng}"

    weather_data = JSON.parse(open(weather_url).read)

    @current_temperature = weather_data["currently"]["temperature"]

    @current_summary = weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = weather_data["hourly"]["summary"]

    @summary_of_next_several_days = weather_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
