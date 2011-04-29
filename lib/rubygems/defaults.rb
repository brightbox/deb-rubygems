module Gem

  @post_install_hooks   ||= []
  @post_uninstall_hooks ||= []
  @pre_uninstall_hooks  ||= []
  @pre_install_hooks    ||= []

  ##
  # An Array of the default sources that come with RubyGems

  def self.default_sources
    %w[http://rubygems.org/]
  end

  ##
  # Default home directory path to be used if an alternate value is not
  # specified in the environment
  #
  # Debian patch: search order of this directory.
  #   1. GEM_HOME enviroment variable
  #      (Using this, Gems are to be installed in any path as you like)
  #   2. /var/lib/gems/{ruby version} (This is the default path in Debian system)
  #

  def self.default_dir
    File.join('/', 'var', 'lib', 'gems', ConfigMap[:ruby_version])
  end

  ##
  # Path for gems in the user's home directory

  def self.user_dir
    File.join Gem.user_home, '.gem', ruby_engine, ConfigMap[:ruby_version]
  end

  ##
  # Default gem load path

  def self.default_path
    if File.exist? Gem.user_home then
      [user_dir, default_dir]
    else
      [default_dir]
    end
  end

  ##
  # Deduce Ruby's --program-prefix and --program-suffix from its install name

  def self.default_exec_format
    exec_format = ConfigMap[:ruby_install_name].sub('ruby', '%s') rescue '%s'

    unless exec_format =~ /%s/ then
      raise Gem::Exception,
        "[BUG] invalid exec_format #{exec_format.inspect}, no %s"
    end

    exec_format
  end

  ##
  # The default directory for binaries
  # Debian patch:
  #   install binaries to /usr/local/bin instead of /usr/bin

  def self.default_bindir
    File.join('/', 'usr', 'local', 'bin')
  end

  ##
  # The default system-wide source info cache directory

  def self.default_system_source_cache_dir
    File.join Gem.dir, 'source_cache'
  end

  ##
  # The default user-specific source info cache directory

  def self.default_user_source_cache_dir
    File.join Gem.user_home, '.gem', 'source_cache'
  end

  ##
  # A wrapper around RUBY_ENGINE const that may not be defined

  def self.ruby_engine
    if defined? RUBY_ENGINE then
      RUBY_ENGINE
    else
      'ruby'
    end
  end

end

