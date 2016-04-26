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


    new_url_weather = "https://api.forecast.io/forecast/f099199e037ae58c402f9dbca74a0a5e/"+@lat+","+@lng
    parsed_data_weather = JSON.parse(open(new_url_weather).read)

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
