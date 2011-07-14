
desc "Import all quotes from nwn.name domain"
task :import => :environment do
  require 'open-uri'

  html = Nokogiri::HTML(open("http://nwn.name/browse/all"))
  html.css("#single_quote").each do |node|
    
    ident = node.children.css("a").text[/[0-9]+/]
    content = node.children.css("#quote").to_s
    content.strip!
    content = content[/<div id="quote">(.+)<\/div>/m, 1]
    content.strip!
    content.encode!("utf-8", "windows-1251")
    content.gsub!("<br>", "")

    #puts content
    #puts "\n"
    #next

    title = node.children.css("#title").text
    u = title[/approved by ([^,]+)/, 1]
    u.capitalize!
    u.strip!

    time = title[/,(.+)/, 1]
    time.strip!

    @quote = Quote.new
    @quote.content = content
    @quote.created_at = time
    @quote.updated_at = time
    @quote.approved_at = time
    @quote.ident = ident

    u = User.where(name: u).first
    @quote.user = u
    @quote.save

    #params = []

    #title = html_quote.css("#title")
    #content = html_quote.css("#quote")
    #params[:content] = content.content
    #puts params[:content]
  end


#  @quotes = Quote.all
#  @quotes.each do |quote|
#    puts quote.content
#  end
end

