require 'socket'

module Jekyll
  class TCPPortChecker < Liquid::Tag
    def initialize(tag_name, args, tokens)
      super
      @host, @port = args.strip.split(':')
      @port = @port.to_i
    end

    def render(context)
      if ENV['JEKYLL_ENV'] == 'production'
        begin
          Socket.tcp(@host, @port, connect_timeout: 5) { |socket| socket.close }
          context.registers[:site].config['tcp_port_open'] = true
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, SocketError, Errno::ENETUNREACH => e
          context.registers[:site].config['tcp_port_open'] = false
        end
      else
        context.registers[:site].config['tcp_port_open'] = true
      end
      ''
    end
  end
end

Liquid::Template.register_tag('check_tcp_port', Jekyll::TCPPortChecker)