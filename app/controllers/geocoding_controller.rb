require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address) #turns input address into the 1600+Street+Mountain View... format for the url

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    require 'open-uri'

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address #append the input address into the url

    raw_data = open(url).read #puts the url API data into the raw_data variable

    require 'json' #pulls the json language bot-thingy for ruby
    JSON.parse(raw_data) #JSON class parse the raw data
    parsed_data = JSON.parse(raw_data) #parsed_data.keys will show you the keys in the API hash
    results = parsed_data["results"] 

    @latitude = results[0]["geometry"]["location"]["lat"]

    @longitude = results[0]["geometry"]["location"]["lng"]

    render("street_to_coords.html.erb")
  end
end
