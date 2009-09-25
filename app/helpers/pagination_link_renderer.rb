class PaginationLinkRenderer < WillPaginate::LinkRenderer
  def to_html
    links = @options[:page_links] ? windowed_links : []
    # previous/next buttons
    links.unshift page_link_or_span(@collection.previous_page, 'disabled prev_page', @options[:previous_label]) unless @options[:previous_label] == false
    links.push    page_link_or_span(@collection.next_page,     'disabled next_page', @options[:next_label]) unless @options[:next_label] == false
    
    html = links.join(@options[:separator])
    @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
  end
end
