require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    url_safe_street_address = URI.encode(@street_address) #this takes out spaces
    raw_url ="http://maps.googleapis.com/maps/api/geocode/json?address=the+corner+of+Foster+and+Sheridan"+url_safe_street_address+"&sensor=false"

    parsed_data = JSON.parse(open(raw_url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
  #lat_safe = URI.encode(latitude)
  #lng_safe = URI.encode(longitude)
    url = "https://api.forecast.io/forecast/6bcf700d56276bc129251de95aa5c558/" + latitude.to_s + "," + longitude.to_s

    parsed_data = JSON.parse(open(url).read)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]
if parsed_data["minutely"].nil?
@summary_of_next_sixty_minutes="No data"
else
@summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
end


    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]


    render("street_to_weather.html.erb")
  end
end
