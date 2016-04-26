require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    require 'JSON'
    url_address="http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    parsed_data_add = JSON.parse(open(url_address).read)
    lat = parsed_data_add["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data_add["results"][0]["geometry"]["location"]["lng"]

    url_weather="https://api.forecast.io/forecast/8ad7a5c93fa0e48f33ab7a8330baca21/"+lat.to_s+","+lng.to_s
    parsed_data_weather = JSON.parse(open(url_weather).read)

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
