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
      command => 'curl -o /usr/local/bin/awslogs-gent-setup.py  https://s3.amazonaws.com//aws-cloudwatch/downloads/latest/awslogs-agent-setup.py',
      path => '/usr/bin',
      notify => Exec['run_awslogs_script'],
  }
  
  exec {
    'run_awslogs_script':
      command => 'python /usr/local/bin/awslogs-agent-setup.py --region=us-east-2 -n -c /etc/awslogs.conf',
      path => '/usr/bin',
      refreshonly => true
  }
}
