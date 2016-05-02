require 'open-uri'

class MeteorologistController < ApplicationController

  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")


  def street_to_weather
    @street_address = params[:user_street_address]
    @url_safe_street_address = URI.encode(@street_address)

    def street_to_coords
      @street_address = params[:user_street_address]
      url_safe_street_address = URI.encode(@street_address)

      def coords_to_weather
        @lat = params[:user_latitude]
        @lng = params[:user_longitude]


    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    #address to latlong
    map_url=
    'http://maps.googleapis.com/maps/api/geocode/json?address='+url_safe_street_address
    parsed_map_data = JSON.parse(open(map_url).read)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    #latlong to weather
    weather_url="https://api.forecast.io/forecast/707613f1dfcb31822b78d669b7d7b731/#{@lat},#{@lng}"
    parsed_weather_data = JSON.parse(open(weather_url).read)
    @current_temperature = parsed_weather_data["currently"]["temperature"]
    @current_summary = parsed_weather_data["currently"]["summary"]
    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]
    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]
    @summary_of_next_several_days =  parsed_weather_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
end
end
end
