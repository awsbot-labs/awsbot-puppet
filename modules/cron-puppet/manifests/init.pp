class cron-puppet {
    file { 'post-hook':
        ensure  => file,
        path    => '/etc/puppet/.git/hooks/post-merge',
        source  => 'puppet:///modules/cron-puppet/post-merge',
        mode    => 0755,
        owner   => root,
        group   => root,
    }
    cron { 'puppet-apply':
        ensure  => present,
        command => "cd /etc/puppet ; /usr/bin/git pull",
        user    => root,
        minute  => '*/1',
        require => File['post-hook'],
    }
    
    cloudwatch_agent::log { '/var/log/puppet.log':
      datetime_format  => '%b %d %H:%M:%S',
      log_stream_name  => '{instance_id}',
      buffer_duration  => '5000',
      initial_position => 'start_of_file',
    }
}
