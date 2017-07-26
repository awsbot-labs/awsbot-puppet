class cloudwatch {
	package { 'libwww-perl':
    		ensure => 'installed',
  	}

	package { 'libdatetime-perl':
    		ensure => 'installed',
  	}

    	file { 'mon-put-instance-data.pl':
	        ensure  => file,
	        path    => '/usr/local/bin/mon-put-instance-data.pl',
	        source  => 'puppet:///modules/cloudwatch/mon-put-instance-data.pl',
	        mode    => 0755,
	        owner   => root,
	        group   => root,
	}

    	file { 'mon-get-instance-stats.pl':
	        ensure  => file,
	        path    => '/usr/local/bin/mon-get-instance-stats.pl',
	        source  => 'puppet:///modules/cloudwatch/mon-get-instance-stats.pl',
	        mode    => 0755,
	        owner   => root,
	        group   => root,
	}

    	file { 'AwsSignatureV4.pm':
	        ensure  => file,
	        path    => '/usr/local/bin/AwsSignatureV4.pm',
	        source  => 'puppet:///modules/cloudwatch/AwsSignatureV4.pm',
	        mode    => 0644,
	        owner   => root,
	        group   => root,
	}

    	file { 'CloudWatchClient.pm':
	        ensure  => file,
	        path    => '/usr/local/bin/CloudWatchClient.pm',
	        source  => 'puppet:///modules/cloudwatch/CloudWatchClient.pm',
	        mode    => 0644,
	        owner   => root,
	        group   => root,
	}

    	cron { 'put-stats':
        	ensure  => present,
	        command => "/usr/local/bin/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --from-cron",
	        user    => root,
	        minute  => '*/1',
	        require => File['mon-put-instance-data.pl'],
	}
}
