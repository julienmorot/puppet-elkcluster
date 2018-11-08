class elkcluster::elasticnode (
    $elkcluster_name   = '',
    $elkcluster_nodes  = '',
	$master            = 'true',
	$data              = 'true',
	$index_number_of_replicas = '1'
) {

	include ::elkcluster
	sysctl { 'vm.max_map_count': value => '262144' }

	limits::fragment {
		"*/soft/nofile":
		value => "65536";
		"*/hard/nofile":
		value => "65536";
	}

	limits::fragment {
		"root/soft/nofile":
		value => "65536";
		"root/hard/nofile":
		value => "65536";
	}

	ensure_packages(['default-jre'], { ensure => present })

	Package { 'elasticsearch':
		ensure   => present,
	}

	file { '/etc/elasticsearch/elasticsearch.yml':
        ensure  => file,
        owner   => 'root',
        group   => 'elasticsearch',
        mode    => '0660',
        content => template("${module_name}/elasticsearch.yml.erb"),
        require => Package['elasticsearch'],
        notify  => Service['elasticsearch'],
    }

    File { '/etc/default/elasticsearch':
        ensure  => file,
        owner   => 'root',
        group   => 'elasticsearch',
        mode    => '0660',
        content => template("${module_name}/etc-default-elasticsearch.erb"),
        require => Package['elasticsearch'],
        notify  => Service['elasticsearch'],
    }


	Service { 'elasticsearch':
		ensure  => 'running',
	}



}

