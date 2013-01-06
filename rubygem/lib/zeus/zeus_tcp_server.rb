require 'socket'

class ZeusTcpServer
  def initialize(port = 3333)
    @port = port
  end

  def start
    @server = TCPServer.new(@port)
    loop do
      run_command(@server.accept)
    end
  end

  def run_command(client)
    pid = fork do
      $stdout.reopen client
      $stderr.reopen client
      if defined?(Bundler)
        Bundler.with_clean_env { exec client.read }
      else
        exec client.read
      end
    end
    Process.waitpid(pid)
  ensure
    client.close()
  end
end
