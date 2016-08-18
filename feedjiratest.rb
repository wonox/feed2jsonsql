# -*- encoding: utf-8 -*-
require "feedjira"
require 'json'
require 'uri'

 class Feedjira::Parser::RSSEntry
  # include SAXMachine
  # include FeedEntryUtilities
  element :"prism:volume", :as => :volume
  element :"prism:number", :as => :number
  element :"prism:startingPage", :as => :startingPage
  element :"prism:endingPage", :as => :endingPage
  element :"prism:publicationDate", :as => :publicationDate
end

keyword = "図書館雑誌"
feedentries2 =[]
for num in 1..40 do
  startnum = (num * 200).to_s
  query = "http://ci.nii.ac.jp/opensearch/search?&journal=" + keyword.encode!("UTF-8") + "&count=200&start="+  startnum +"&lang=ja&title=&author=&affiliation=&issn=&volume=&issue=&page=&publisher=&references=&year_from=&year_to=&range=&sortorder=&format=rss"
  #http://ci.nii.ac.jp/opensearch/search?range=0&nrid=&journal=%E5%9B%B3%E6%9B%B8%E9%A4%A8%E9%9B%91%E8%AA%8C&count=200&sortorder=1&type=1&format=rss
  query_escape = URI.escape(query)

  feed = Feedjira::Feed.fetch_and_parse(query_escape)
  # feed = Feedjira::Feed.fetch_and_parse("http://ci.nii.ac.jp/opensearch/search?q=%E5%9B%B3%E6%9B%B8%E9%A4%A8%E9%9B%91%E8%AA%8C&count=200&start=2201&lang=ja&title=&author=&affiliation=&journal=&issn=&volume=&issue=&%20page=&publisher=&references=&year_from=&year_to=&range=&sortorder=&format=rss")

  # puts feed.entries.map { |entry| entry.inject({}) { |obj, attr| obj[attr[0]] = attr[1]; obj }}.to_json


#  feedentries = {"title"=>"", "url"=>"", "volume"=>"", "number"=>"", "publicationDate"=>"", "published"=>"", "author"=>"aaaaaaaaaaaaaaaaaaaaaaa"}
  feedentries = feed.entries.map { |entry| entry.inject({}) { |obj, attr| obj[attr[0]] = attr[1]; obj }}

# authorキーが存在しなければキーをセット
  feedentries.each{|var|
    if !var.has_key?('author')
      # puts var.keys
      var.store("author", "")
    end
  }

feedentries2 += feedentries

# entryが空になったら終了
if feed.entries.empty?
  break
end
sleep(0.02) # とりあえずインターバルをいれておく 20mm秒
end

puts '{"channel":'
puts feedentries2.to_json
puts "}"
# puts feed.entries.map { |entry| entry.inject({}) { |obj, attr| obj[attr[0]] = attr[1]; obj } }.to_json
# puts JSON.pretty_generate(feed.entries.map { |entry| entry.inject({}) { |obj, attr| obj[attr[0]] = attr[1]; obj } })
