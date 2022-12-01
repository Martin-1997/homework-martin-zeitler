class HealthRoutes < Sinatra::Base

  get('/') do
    # I really do not unterstand how to check this parameter 
    #Base64.decode64(request.env["rack.input"])
    # request.env 
    # # HTTP_AUTH instead of AUTHED
    # if request.env['AUTHED'].nil?
    #  Maybe the status needs to be defined 
      'App working OK'
    #   request
    # else
    #   {status: 403}
    # end
  end
end
