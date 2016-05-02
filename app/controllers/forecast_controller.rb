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

    # url =  "https://api.forecast.io/forecast/71450c71080f36de39fd4cfe1f9a60cd/"+@lat+","+@lng

    # url = "https://api.forecast.io/forecast/79949523716c2e151a22ed58fc66708f/#{@lat},#{@lng}"
    #
    # parsed_data = JSON.parse(open(url).read)


    # @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    # darkdata = open(url).read

    url = "https://api.forecast.io/forecast/71450c71080f36de39fd4cfe1f9a60cd/"+@lat+","+@lng
   parsed_data = JSON.parse(open(url).read)


    # @current_temperature = darkdata["currently"]["time"]

    @current_summary = "Replace this string with your answer."

    @summary_of_next_sixty_minutes = "Replace this string with your answer."

    @summary_of_next_several_hours = "Replace this string with your answer."

    @summary_of_next_several_days = "Replace this string with your answer."

    render("coords_to_weather.html.erb")
  end
end
