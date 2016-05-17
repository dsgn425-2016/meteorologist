require 'open-uri'
require 'json'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    url = "https://api.forecast.io/forecast/ddce898aeeb382c05c2a54f09f2bd74f/"+@lat+","+@lng
    #https://api.forecast.io/forecast/ddce898aeeb382c05c2a54f09f2bd74f/37.8267,-122.423

    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days =parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
