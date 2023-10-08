class WistiaService
  ALLOWED_VIDEO_FORMATS = %w(
    video/quicktime video/mpeg video/avi video/x-flv video/x-f4v
    video/mp4 video/x-m4v video/x-ms-asf video/x-ms-wmv video/x-ms-wmx
    video/x-ms-wvx video/vob video/mod video/3gpp video/3gpp2
    video/x-matroska video/divx video/xvid video/webm
  )
  
  def initialize
    @url = 'https://upload.wistia.com/'
  end
  
  def upload_video video_url, name = ""
    request = Net::HTTP::Post::Multipart.new uri.request_uri, {
      'access_token' => ENV["WISTIA_ACCESS_TOKEN"],
      'file' => UploadIO.new(
                  File.open(path_to_video),
                  'application/octet-stream',
                  File.basename(path_to_video)
                )
    }
    response = http.request(request)
    
    if response.code == "401"
      puts "Excedio el limite de videos"
      return "Excedio el limite de videos"
    else
      id = JSON.parse(response.body)["thumbnail"]["url"]
      id = id.split('/').last.split('.').first
      url = "http://embed.wistia.com/deliveries/#{id}.bin"
      return url
    end
  end
  
  def valid_video_format? content_type
    ALLOWED_VIDEO_FORMATS.include?(content_type)
  end
end