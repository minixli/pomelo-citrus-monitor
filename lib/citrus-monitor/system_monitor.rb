# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 7 July 2014

module CitrusMonitor
  # SystemMonitor
  #
  #
  module SystemMonitor
    include Utils

    # Get operating system's information
    def get_sys_info &block
      return if OS.windows?

      sys_info = get_basic_info

      EM.system('iostat') { |output, status|
        if status.exitstatus == 0
          sys_info[:iostat] = format output
          block_given? and yield nil, sys_info
        else
          block_given? and yield status, sys_info
        end
      }
    end

    private

    # Get operating system's basic info
    #
    # @private
    def get_basic_info
      info = {}
      report = YAML.load OS.report
      report.each_pair { |key, value| info[key.to_sym] = value }
      return info
    end

    # Analyze the disk i/o data, return a map contains kb_read, kb_wrtn, etc
    #
    # @private
    def format data
      time = get_current_time

      data = data.gsub(/^\s+|\s+$/, '')
      data = data.split(/\s+/).select { |str|
        Float str rescue nil
      }

      return {
        :date => time,
        :disk => {
          :kb_read => data[9] || '',
          :kb_wrtn => data[10] || '',
          :kb_read_per => data[7] || '',
          :kb_wrtn_per => data[8] || '',
          :tps => data[6] || ''
        },
        :cpu => {
          :cpu_user => data[0] || '',
          :cpu_nice => data[1] || '',
          :cpu_system => data[2] || '',
          :cpu_iowait => data[3] || '',
          :cpu_steal => data[4] || '',
          :cpu_idle => data[5] || ''
        }
      }
    end
  end
end
