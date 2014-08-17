# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 7 July 2014

module CitrusMonitor
  # Utils
  #
  #
  module Utils
    # Get current time in yyyy-mm-dd hh:mm:ss format
    #
    # @return [String]
    def get_current_time
      Time.now.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end
