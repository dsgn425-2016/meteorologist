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

url_call = "https://api.forecast.io/forecast/62a9f77da28e0440a0702d3f8d15ae13/" + @lat + "," + @lng
raw_data= open(url_call).read #read data
parsed_data = JSON.parse(raw_data) #convert to JSON
currently = parsed_data["currently"] #pull currently key
minutely = parsed_data["minutely"] #pull minutely key
hourly = parsed_data["hourly"] #pull currently key
daily = parsed_data["daily"] #pull daily key


    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("coords_to_weather.html.erb")
  end
end
