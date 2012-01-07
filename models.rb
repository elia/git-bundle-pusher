require 'git'
require 'logger'
require 'mongoid'
Mongoid.load!('config/mongoid.yml')

class Repo
  # git-bundle-pusher:master> git bundle create updates-2011-12-10.git-bundle releases --not v0.2.5

  include Mongoid::Document
  field :name
  field :origin
  
  validates :name, presence: true, format: /^[\w\-_]+$/
  validates :origin, presence: true, uniqueness: true
  
  def pull source
    git.pull
    logger.info '===' * 40
    git.lib.send(:command,'pull', [source, 'master'])
    # git.pull(source, 'master')
  end
  
  def push
    git.push
  end
  
  def dir
    @dir ||= "tmp/repos/#{name}"
  end
  
  def git
    return @git if @git
    
    unless File.exists? dir and File.directory? dir
      @git = Git.clone origin, dir, log: Logger.new(STDOUT)
    else
      @git = Git.open dir, log: Logger.new(STDOUT)
    end
  end
end
