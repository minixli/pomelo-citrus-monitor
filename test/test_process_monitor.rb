# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 7 July 2014

require File.expand_path('../../lib/citrus-monitor', __FILE__)

include CitrusMonitor::ProcessMonitor

EM.run {
  pid = 428
  args = {
    :pid => pid,
    :server_id => 'auth-server-1'
  }

  get_ps_info(args) { |status, data|
    puts data
    EM.add_timer(0.1) { EM.stop_event_loop }
  }
}
