require 'open-uri'
require 'json'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    url_location = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&"

    parsed_data_location = JSON.parse(open(url_location).read)
    lat = parsed_data_location["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data_location["results"][0]["geometry"]["location"]["lng"]

    url_weather = "https://api.forecast.io/forecast/ddce898aeeb382c05c2a54f09f2bd74f/"+lat.to_s+","+lng.to_s
    #https://api.forecast.io/forecast/ddce898aeeb382c05c2a54f09f2bd74f/37.8267,-122.423

    parsed_data_weather = JSON.parse(open(url_weather).read)

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days =parsed_data_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
