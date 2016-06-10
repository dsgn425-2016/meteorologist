require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url_call = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    raw_data= open(url_call).read  # read data
    parsed_data = JSON.parse(raw_data)  # convert to JSON
    results = parsed_data["results"]  # only pull result key


    @latitude = results[0]["geometry"]["location"]["lat"] #pull latitude key

    @longitude = results[0]["geometry"]["location"]["lng"] #pull longitude key

    render("street_to_coords.html.erb")
  end
end
