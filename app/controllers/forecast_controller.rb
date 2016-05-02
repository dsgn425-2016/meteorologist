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
    require "JSON"
    url = "https://api.forecast.io/forecast/1e6df356aabe300b443cdd5ed5c173d3/json?address=#{user_latitude user_longitude}"
    parsed_data = JSON.parse(open(url).read)
    results = parsed_data["results"]

    @current_temperature = "Replace this string with your answer."

    @current_summary = "Replace this string with your answer."

    @summary_of_next_sixty_minutes = "Replace this string with your answer."

    @summary_of_next_several_hours = "Replace this string with your answer."

    @summary_of_next_several_days = "Replace this string with your answer."

    render("coords_to_weather.html.erb")
  end
end
