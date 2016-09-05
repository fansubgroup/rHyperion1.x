#!/usr/bin/ruby
#coding:utf-8
require 'open-uri'
require 'uri'
require 'digest/md5'
require 'json'
require 'ffi'
module Nim
  extend FFI::Library
  ffi_lib './libhttp2.so'
  attach_function :http_get,[:string],:string
end
module Go
  extend FFI::Library
  ffi_lib './libgo.so'
  attach_function :http_get,[:string],:string
end
Keyfile = "appkey"
Resultfile = "result.srt"
Tmpengtxt = "english.txt"
Tmprestxt = "result.txt"
Tmptimetxt = "timeline.txt"
Tmpnumtxt = "num.txt"
def search_file(path,words)
  Dir.foreach(path) do |f|
    re = /#{Regexp.escape(words)}/
    if re.match(f) != nil
      puts " <<< [ "+f+" ] >>> "
      puts "Translation this file?[y/n]"
      mark = true
      while mark
        cmd = gets.strip
        case cmd
        when 'y' then
          mark = false
          return f
        when 'n' then
          mark = false
          return false
        else
          puts "invalid value,please input again![y/n]"
        end
      end
    end
  end
    puts "No such file >_<!"
    puts "Please check your name again >0<!"
    return false
end
def input_name()
  puts "Input your file name:"
  name = gets.strip
  file = search_file(Dir.pwd,name)
  if file
    puts file
    return file
  else
    puts "Over the translation"
    exit(0)
  end
end
$numlist = []
$timelist = []
$englist = []
$reslist = []
$marklist = []
def split_file()
  puts "<Start split>"
  filename  = input_name()
  puts filename
  IO.readlines(filename).each do |line|
    #puts line
    case line
    when /--\>/ then
      $numlist.push(nil)
      $timelist.push(line)
      $englist.push(nil)
      $marklist.push("time")
    when /[A-Za-z]/ then
      $numlist.push(nil)
      $timelist.push(nil)
      $englist.push(line)
      $marklist.push("words")
    when /[0-9]/ then
      $numlist.push(line)
      $timelist.push(nil)
      $englist.push(nil)
      $marklist.push("num")
    else
    end
    f = File.new(Tmptimetxt,"w+")
    $timelist.each{|line|f.puts(line)}
    f.close
    f = File.new(Tmpengtxt,"w+")
    $englist.each{|line|f.puts(line)}
    f.close
    f = File.new(Tmpnumtxt,"w+")
    $numlist.each{|line|f.puts(line)}
    f.close
  end
end
def input_key()
  puts "[Please input your appid and secretkey]"
  puts "Input your appid"
  appid = gets.strip
  puts "Input your secretkey"
  key = gets.strip
  f = open(Keyfile,"w+")
  f.puts appid,key
  f.close
  return {"appid"=>appid,"key"=>key}
end
def appid_set()
  if(File.exist?(Keyfile))
    fp = File.open(Keyfile,"r")
    appid = fp.readline
    key = fp.readline
    fp.close
    if appid != "" && key != ""
      return {"appid"=>appid,"key"=>key}
    else
      return input_key
    end
  else
    File.new(Keyfile,"w").close
    return input_key
  end
end
def trans_file(src,dst)
  puts src,dst
  puts "<Start translation>"
  user = appid_set
  appid = user['appid'].strip
  key = user['key'].strip
  puts "Please choose the http get engine:","1: Ruby open-uri",
       "2: Go net/http","3: Nim httpclient"
  puts "Please input the index of http engine:"
  choose = gets.strip
  http_get = lambda{|url|open(url,&:read)}
  case choose
  when "1" then
    http_get = lambda{|url|open(url,&:read)}
  when "2" then
    http_get = lambda{|url|Go.http_get(url)}
  when "3" then
    http_get = lambda{|url|Nim.http_get(url)}
  else
    puts "invalid value , use default engine:Ruby open-uri"
  end
  IO.readlines(Tmpengtxt).each do |line|
    if line != "\n"
      salt = (rand(32768)+32768).to_s
      q = URI.escape(line)
      sign = Digest::MD5.hexdigest(appid+line+salt+key)
      url = 'http://api.fanyi.baidu.com/api/trans/vip/translate' +
            "?appid=#{appid}"+"&q=#{q}"+"&from=#{src}"+"&to=#{dst}"+"&salt=#{salt}"+"&sign=#{sign}"
      body = http_get.call(url)
      result = JSON.load(body)
      puts result
      #puts result["trans_result"][0]["dst"]
      $reslist.push(result["trans_result"][0]["dst"])
    else
      $reslist.push(nil)
    end
    f = File.new(Tmprestxt,"w+")
    $reslist.each{|line|f.puts(line)}
    f.close
  end
  puts "<End translation>"
end
def join_file()
  fp = File.new(Resultfile,"w+")
  loop = 0
  for i in 0..$marklist.length do
    case $marklist[i]
    when "num" then
      fp.puts "\n"
      fp.puts $numlist[i]
      i+=1
    when "time" then
      fp.puts $timelist[i]
      i+=1
    when "words" then
      fp.puts $reslist[i]
      i+= 1
    else
    end
  end
  fp.close
end
def delete_file()
  puts "<Start detele>"
  File.delete(Tmpengtxt) if File.exist?(Tmpengtxt)
  File.delete(Tmptimetxt) if File.exist?(Tmptimetxt)
  File.delete(Tmpnumtxt) if File.exist?(Tmpnumtxt)
  File.delete(Tmprestxt) if File.exist?(Tmprestxt)
  puts "<End detele>"
end
if ARGV.length != 2
  puts "Usage: ./trans.rb (or ruby trans.rb) source_language target_language"
  exit(0)
end
src = ARGV[0]
dst = ARGV[1]
ARGV.clear
split_file()
trans_file(src,dst)
join_file()
delete_file()
