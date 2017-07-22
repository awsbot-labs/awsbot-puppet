class mymodule::myklass{

  file {
    'copy_awslogs_conf':
      ensure => 'file',
      source => 'puppet:///modules/awslogs/awslog.conf',
      path   => '/etc/awslogs.conf',
      owner  => 'root',
      group  => 'root',
      mode   => '0644', 
      notify => Exec['run_awslogs_script'],
  }

  exec {
    'run_awslogs_script':
      command => 'python /etc/puppet/modules/awslogs/files/awslogs-agent-setup-debian.py --region=us-east-2 -n -f /etc/awslogs.conf',
      refreshonly => true
  }
}
