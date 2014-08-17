# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 7 July 2014

module CitrusMonitor
  # ProcessMonitor
  #
  #
  module ProcessMonitor
    include Utils

    # Get process information by command 'ps auxw | grep serverId | grep pid'
    #
    # @param [Hash] args Options
    #
    # @option args [Integer] :pid
    # @option args [String]  :server_id
    def get_ps_info args={}, &block
      return if OS.windows?

      pid = args[:pid]

      EM.system('sh', proc{ |process|
        process.send_data "ps auxw | grep " + pid.to_s + " | grep -v 'grep'\n"
        process.send_data "exit\n"
      }) { |output, status|
        if status.exitstatus == 0
          format args, output, &block
        else
          block.call status, nil if block
        end
      }
    end

    private

    # Convert process information into required format
    #
    # @param [Hash] args Options
    #
    # @option args [Integer] :pid
    # @option args [String]  :server_id
    #
    # @param [String] output
    #
    # @private
    def format args, data
      time = get_current_time

      data = data.gsub(/^\s+|\s+$/, '')
      data = data.split(/\s+/).select { |str|
        Float str rescue nil
      }

      ps_info = {}
      ps_info[:time] = time
      ps_info[:server_id] = args[:server_id]
      ps_info[:server_type] = args[:server_id].split('-')[0]
      pid = ps_info[:pid] = args[:pid]
      ps_info[:cpu_avg] = data[1]
      ps_info[:mem_avg] = data[2]
      ps_info[:vsz] = data[3]
      ps_info[:rss] = data[4]

      if OS.mac?
        ps_info[:usr] = ps_info[:sys] = ps_info[:gue] = '0'
        block_given? and yield nil, ps_info
        return
      end

      EM.system('pidstat -p ' + pid) { |output,status|
        if status.exitstatus == 0
          data = output.gsub(/^\s+|\s+$/, '')
          data = data.split(/\s+/).select { |str|
            Float str rescue nil
          }
          ps_info[:usr] = data[1]
          ps_info[:sys] = data[2]
          ps_info[:gue] = data[3]
          block_given? and yield nil, ps_info
        else
          block_given? and yield status, nil
        end
      }
    end
  end
end
