def auto_embed_youtube(description)
  src = description.match(/\Ahttps:\/\/www.youtube.com\/watch\?v=(\w+)/).captures[0]
  auto_embedded_html = "<iframe width='560' height='315' src='//www.youtube.com/embed/#{src}' frameborder='0' allowfullscreen></iframe>"
  return auto_embedded_html
end
