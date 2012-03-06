#require 'rubygems'
#require 'flickr_fu'

module Flickrpu

  class Base
    
    attr_accessor :photo_class_name, :config, :num_photos, :opts, :klass_opts, :flickr

    def initialize(photo_class_name = "Photo", num_photos = 10, opts = {}, &klass_opts)
      
      self.photo_class_name = photo_class_name
      self.num_photos = num_photos
      self.opts = opts
      self.klass_opts = klass_opts
      self.config = {
        'key' => opts[:key],
        'secret' => opts[:secret]
      }
      self
    end
    
    def klass
      Kernel.const_get(self.photo_class_name.capitalize)
    end

    def save(flickr_photo)
      flickr_url             = flickr_photo.url
      puts "Saving #{flickr_url}"
      
      photo                  = self.klass.new
      self.klass_opts.call(photo) if self.klass_opts
      filename               = rand(36**12).to_s(36)+'.jpg'
      amazon_file            = {
        :filename            => filename,
        :type                => 'image/jpeg',
        :tempfile            => open(flickr_url)
      }
      photo.amazon_file      = amazon_file

      if photo.valid?
        photo.save
      else
        puts "Couldn't save photo #{photo.inspect} :("
        photo.errors.each do |e|
          puts e
        end
      end
      1
    rescue NoMethodError => e
      puts e.to_s
      0
    rescue TypeError => e
      puts "Couldn't retrieve Flickr url: #{e.to_s}"
      exit
    end
    
    def self.from_file(dir, filename)
      temp_file = copy_to_tempfile(dir, filename)
      opt_obj = OpenStruct.new
      opt_obj.url = temp_file
      self.save(opt_obj)
      File.safe_unlink(temp_file)
    end
    
    def from_file(dir, filename)
      self.class.from_file(dir, filename)
    end
    
    def self.copy_to_tempfile(dir, filename)
      tmp_dir = File.join('.', 'tmp')
      Dir.mkdir(tmp_dir) if not File.directory?(tmp_dir)
      File.copy(File.join(dir, filename), File.join(tmp_dir, filename), verbose = true)
      temp_file
    end

    def search
      puts self.config.inspect
      self.flickr = ::Flickr.new(self.config)
      this_photo = 0
      flickr_photos = self.flickr.photos.get_recent({:per_page=>self.num_photos})
      flickr_photos.each do |photo|
        return if this_photo >= self.num_photos
        this_photo += self.save(photo)
      end
    end
      
    
  end
end