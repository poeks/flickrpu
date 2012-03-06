Installation
------------
* gem install flickrpu

Initialization
--------------
* `require 'flickrpu'`

Usage
-----
`class Photo
  attr_accessor :some_arbitrary_thing, :amazon_file
  def save
    your_s3_magic
  end
  def valid?; true; end
end

flickr = Flickrpu::Base.new("photo", num_photos, {:key => 'your key', :secret => 'your secret'}) do |photo|
  photo.some_arbitrary_thing = thing
end
flickr.search`

Notes
-----
Flickrpu saves an "amazon_file" field into your object and calls the "save" method on it. Your S3 magic should take these jams into account.