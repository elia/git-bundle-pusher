require 'mongoid'
Mongoid.load!('config/mongoid.yml')
puts Mongoid.master.inspect

class Repo
  include Mongoid::Document
  field :name
  field :origin
  
  validates :name, presence: true, format: /^[\w\-_]+$/
  validates :origin, presence: true, uniqueness: true
  
  def self.dir
    return @dir if @dir
    
    @dir = File.expand_path('../tmp', __FILE__)
    File.mkdir tmp unless File.exists? tmp and File.directory? tmp
  end
  
  def pull
    
  end
end
