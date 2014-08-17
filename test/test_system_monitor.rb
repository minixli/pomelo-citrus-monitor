# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 7 July 2014

require File.expand_path('../../lib/citrus-monitor', __FILE__)

include CitrusMonitor::SystemMonitor

EM.run {
  get_sys_info { |status, data|
    puts data

    EM.add_timer(0.1) { EM.stop_event_loop }
  }
}
