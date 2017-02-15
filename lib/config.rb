require 'config/version'

module HawkPrime
  # Config.
  #
  # Searches from the current directory backwards for an
  # environment file. File is named .env by default but
  # can be overriden by environment variable:
  #
  #   ENV_VARS=my-env-vars
  #
  class Config
    STATIC_METHODS = %w(:register :registered? :var? :load :to_s).freeze

    @@objects = {}
    @@config = nil

    def self.[](key)
      return @@config[key] if !@@config.nil? && @@config.key?(key)
      return ENV[key.to_s] if ENV.key? key.to_s
      ENV[key.to_s.upcase]
    end

    def self.[]=(key, value)
      @@config ||= {}
      @@config[key] = value
      ENV[key.to_s.upcase] = value
    end

    def self.var?(key)
      (!@@config.nil? && @@config.key?(key)) || ENV.key?(key.to_s) || ENV.key?(key.to_s.upcase)
    end

    def self.register(name, object)
      raise "Cannot use reserved name #{name}" if STATIC_METHODS.include? name
      define_singleton_method name do
        object
      end
    end

    def self.registered?(name)
      respond_to? name
    end

    def self.load
      load_env_file if @@config.nil?
    end

    def self.to_s
      "Config: #{@@config} Environment:#{ENV.inspect}"
    end

    class << self
      ENV_FILE = '.env'.freeze
      READ_ONLY = 'r'.freeze

      private

      def load_env_file
        @@config = {}
        env_file = find_env_file
        return unless env_file
        File.open(env_file, READ_ONLY) do |f|
          f.each_line { |line| parse_env_file_line(line) }
        end
      end

      def parse_env_file_line(line)
        return if line =~ /^\s*(#.*)?$/
        key, value = line.rstrip.split(/\s*=\s*/)
        ENV[key] = value
        @@config[key.downcase.to_sym] = value
      end

      def find_env_file
        dir = File.join(Dir.pwd, ENV_FILE)
        loop do
          dir = File.dirname(dir)
          file = File.join(dir, ENV.key?('ENV_VARS') ? ENV['ENV_VARS'] : ENV_FILE)
          if File.exist? file
            puts "Reading environment file \"#{file}\""
            return file
          end
          return nil if ['.', '/'].include? dir
        end
      end
    end
  end
end
