require "json"
require "http"
require "optparse"
# require "pry"

API_KEY = 'dSpOzosE_0tn0aKFycd0FLI230-Xve3W-jZxcpmfCnG7mPxC_-pPUWxj6V0PTHSar0ihkK3UFIdNyew3u_bUPr62UWPWuFpxl7jB2QmtX_V_6SriBkcJTBuFPcpGW3Yx'

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  

DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "San Francisco, CA"
SEARCH_LIMIT = 50

def search(term, location)
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      term: term,
      location: location,
      limit: SEARCH_LIMIT
    }
  
    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    response.parse
  end

  # binding.pry
  # false