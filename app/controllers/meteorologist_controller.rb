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

    # url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    # parsed_data = JSON.parse(open(url).read)
    # @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    # @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    #
    # url2 = "https://api.forecast.io/forecast/2484b627ac9329661de4f85e4c6788ba/#{url_safe_street_address}"
    # parsed_data = JSON.parse(open(url2).read)

    @current_temperature = "Replace this string with your answer."

    @current_summary = "Replace this string with your answer."

    @summary_of_next_sixty_minutes = "Replace this string with your answer."

    @summary_of_next_several_hours = "Replace this string with your answer."

    @summary_of_next_several_days = "Replace this string with your answer."

    render("street_to_weather.html.erb")
  end
end
