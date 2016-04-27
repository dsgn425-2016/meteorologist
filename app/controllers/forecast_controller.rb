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
lat = @lat
lng = @lng

require 'json'
url = "https://api.forecast.io/forecast/8ecb5c3c292fb07c022c5f685dc1b6b7/" + lat + "," + lng
parsed_data = JSON.parse(open(url).read)

temp = parsed_data["currently"]["temperature"]
summary_current = parsed_data["currently"]["summary"]
summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
summary_of_next_several_hours = parsed_data["hourly"]["summary"]
summary_of_next_several_days = parsed_data["daily"]["summary"]


    @current_temperature = temp

    @current_summary = summary_current

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("coords_to_weather.html.erb")
  end
end
