require "rubygems"
require "tmpdir"

require "bundler/setup"
require "jekyll"

def say_what? message
  print message
  STDIN.gets.chomp
end

def sluggize str
  str.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '');
end

desc "Generate blog files"
task :generate do
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site"
  })).process
end

desc "Generate and publish blog to gh-pages"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp
    Dir.chdir tmp
    system "git init"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.inspect}"
    system "git remote add origin git@github.com:mhulse/mhulse.github.io.git"
    system "git push origin master --force"
  end
end

desc "Create a new post"
task :new do
  
  title     = say_what?('Title: ')
  filename  = "_posts/#{Time.now.strftime('%Y-%m-%d')}-#{sluggize title}.md"
  
  if File.exist? filename
    puts "Can't create new post: \e[33m#{filename}\e[0m"
    puts "  \e[31m- Path already exists.\e[0m"
    exit 1
  end
  
  File.open(filename, "w") do |post|
    post.puts "---"
    post.puts "layout:    post"
    post.puts "title:     #{title}"
    post.puts "---"
    post.puts ""
    post.puts "Once upon a time..."
  end
  
  puts "A new post was created for at:"
  puts "  \e[32m#{filename}\e[0m"
  
end
