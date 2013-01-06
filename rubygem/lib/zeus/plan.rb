module Zeus
  class Plan
    def after_fork ; end

    def tcp
      port = (ARGV[0] || 3333).to_i
      puts "running on zeus tcp on port #{port}"
      ZeusTcpServer.new(port).start
    end
  end
end

