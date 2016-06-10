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

    url_call_street = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    parsed_data_street = JSON.parse(open(url_call_street).read)

    @latitude = parsed_data_street["results"][0]["geometry"]["location"]["lat"] #pull latitude key
    @longitude = parsed_data_street["results"][0]["geometry"]["location"]["lng"] #pull longitude key

    url_call_weather = "https://api.forecast.io/forecast/62a9f77da28e0440a0702d3f8d15ae13/" + @latitude.to_s + "," + @longitude.to_s
    parsed_data_weather = JSON.parse(open(url_call_weather).read) #convert to JSON
    # currently = parsed_data_weather["currently"] #pull currently key
    # minutely = parsed_data_weather["minutely"] #pull minutely key
    # hourly = parsed_data_weather["hourly"] #pull currently key
    # daily = parsed_data_weather["daily"] #pull daily key

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
