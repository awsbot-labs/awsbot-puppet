node default {
    class { 'cloudwatch_agent':
      region => 'us-east-2',
    }
    include cron-puppet
    include vim
}
