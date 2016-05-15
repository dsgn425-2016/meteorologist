require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
  #@street_address[-1] {|x| x.is_a? Integer}
@apt_test = @street_address[-1]

if @apt_test == "0" then
  @apt_test = "1"
end
@apt_test = @apt_test.to_i
if @apt_test >= 1
  then
  @street_address = @street_address.split[0..-2].join(" ")
end
    @url_safe_street_address = URI.encode(@street_address)


    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    require 'open-uri'
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_street_address}"

    require 'json'
        parsed_data = JSON.parse(open(url).read)
        @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
        @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
        @type = parsed_data["results"][0]["address_components"][0]["types"][0]

        if @type = "street_number" then
        @street_number = parsed_data["results"][0]["address_components"][0]["long_name"]
        @street = parsed_data["results"][0]["address_components"][1]["short_name"]
        #@street_name = "fuck you"
        @street_name = @street
        @street_rose = @street.split[0]
        @street_suffix = @street.split[-1]


        if @street_suffix ==  "Blvd" || "Ct" || "Dr" || "Ln"|| "Pkwy" || "Pl" || "St" || "Ave"
         @street_suffix = @street.split[-1]
         @street_name = @street.split[0..-2].join(" ")
        else
          @street_suffix = ""
        end

        #@street_name = @street.split
        @street_rose = @street_name[0]

        if @street_rose == "S" || @street_rose == "N" || @street_rose == "W" || @street_rose == "E" then
          @street_rose = @street.split[0]
          @street_name = @street_name.split[1..-1].join(" ")
        else
          @street_rose = ""

        end

elsif @type = "subpremise" then
    @street_name = parsed_data["results"][0]["address_components"][2]["long_name"]
  end

    require 'open-uri'
        url = "https://api.forecast.io/forecast/d387b8fb36b2aefdf789af0335e401e0/#{@latitude},#{@longitude}"

    require 'json'
        parsed_data = JSON.parse(open(url).read)
        @current_temperature = parsed_data["currently"]["temperature"]

        @current_summary = parsed_data["currently"]["summary"]

        @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

        @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

        @summary_of_next_several_days = parsed_data["daily"]["summary"]




    render("street_to_weather.html.erb")
  end
end
