class awslogs {

  file {
    'copy_awslogs_conf':
      ensure => 'file',
      source => 'puppet:///modules/awslogs/awslogs.conf',
      path   => '/etc/awslogs.conf',
      owner  => 'root',
      group  => 'root',
      mode   => '0644', 
      notify => Exec['get_awslogs_script'],
  }

  exec {
    'get_awslogs_script':
      command => 'curl -o /usr/local/bin/awslogs-agent-setup.py  https://s3.amazonaws.com//aws-cloudwatch/downloads/latest/awslogs-agent-setup.py',
      path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
      notify => Exec['run_awslogs_script'],
  }
  
  exec {
    'run_awslogs_script':
      command => 'python /usr/local/bin/awslogs-agent-setup.py --region=us-east-2 -n -c /etc/awslogs.conf',
      path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
      notify => Service['awslogs']
  }

  service { 'awslogs':
	ensure => 'running',
	enable => 'true',
	hasrestart => 'true',
	hasstatus => 'true',
  }
}
