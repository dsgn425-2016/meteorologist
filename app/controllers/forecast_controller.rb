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

    require 'json'

    forecast_api_url = 'https://api.forecast.io/forecast/c747127dcd3682eb6ccf4c85504bdab6/'+@lat.to_s+','+@lng.to_s

    forecast_parsed_data = JSON.parse(open(forecast_api_url).read)

    @current_temperature = forecast_parsed_data["currently"]["temperature"]

    @current_summary = forecast_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = forecast_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = forecast_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = forecast_parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
