helpers do
  def auto_embed_youtube(html)
    if youtube_link = html.match(/https:\/\/www.youtube.com\/watch\?v=(\w+\W+\w+)/)
      src = youtube_link.captures[0]
      html.gsub!(/https:\/\/www.youtube.com\/watch\?v=(\w+\W+\w+)/, "<iframe width='560' height='315' src='//www.youtube.com/embed/#{src}' frameborder='0' allowfullscreen></iframe>")
    end
    return html
  end

  def auto_embed_links(description)
    html = description.dup
    html.gsub!(/\r\n/, "\n")
    if links = html.scan(/(\n)?(http:\/\/)?(https:\/\/)?([\da-z\.-]+\.[a-z\.]{2,6}\/?\S*)/)
      links.each do |captures|
        p captures
        if captures.last.match(/\Awww.youtube.com\/watch\?v=\w+/)
          next
        elsif !captures[1].nil?
          link = captures[1] + captures.last
          html.gsub!(link, "<a href='#{link}' target='_blank'>#{link}</a>")
        elsif !captures[2].nil?
          link = captures[2] + captures.last
          html.gsub!(link, "<a href='#{link}' target='_blank'>#{link}</a>")
        else
          if captures.last.match(/\Awww.youtube.com/)
            next
          else
            html.gsub!(captures.last, "<a href='http://#{captures.last}' target='_blank'>#{captures.last}</a>")
          end
        end
      end
      return html
    else
      return description
    end
  end
end