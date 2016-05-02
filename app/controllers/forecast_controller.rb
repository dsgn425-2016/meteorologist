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


    #
    # parsed_data = JSON.parse(open(url).read)


    # @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    # darkdata = open(url).read

    # url = "https://api.forecast.io/forecast/71450c71080f36de39fd4cfe1f9a60cd/"+@lat.to_s+","+@lng.to_s

    # url = "https://api.forecast.io/forecast/79949523716c2e151a22ed58fc66708f/" + @lat.to_s + "," + @lng.to_s
    # parsed_data1 = JSON.parse(open(url).read)




    # ------------Works----------------
    url_forecast = "https://api.forecast.io/forecast/4c161d79ae009ea2445d7191e4a6f2cc/" + @lat.to_s + "," + @lng.to_s

    parsed_data1 = JSON.parse(open(url_forecast).read)

    @current_temperature = parsed_data1["currently"]["temperature"]

    @current_summary = parsed_data1["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data1["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data1["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data1["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
