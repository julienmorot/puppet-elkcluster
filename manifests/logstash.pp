class elkcluster::logstash (
) {

    include ::elkcluster
    ensure_packages(['default-jre'], { ensure => present })

    File { '/etc/logstash':
        ensure => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0775',
    }

#   File { '/etc/logstash/logstash.yml':
#       ensure  => file,
#       owner   => 'root',
#       group   => 'root',
#       mode    => '0644',
#       content => template("${module_name}/logstash.yml.erb"),
#       require => Package['logstash'],
#       notify  => Service['logstash'],
#   }

   File { '/etc/logstash/jvm.options':
       ensure  => file,
       owner   => 'root',
       group   => 'root',
       mode    => '0644',
       content => template("${module_name}/logstash/jvm.options.erb"),
       require => File['/etc/logstash'],
       notify  => Service['logstash'],
   }

    # Workaround because logstash doesn't start with UseParNewGC JVM options
    #And the behaviour prevent apt to finish logtash installation
    Package { 'logstash':
        ensure   => "6.6.1",
        require => File['/etc/logstash/jvm.options'],
    }

    Service { 'logstash':
        ensure  => 'running',
        enable  => 'true',
        require => File['/etc/logstash/jvm.options']
    }

}

