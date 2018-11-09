class elkcluster::filebeat (
) {

	include ::elkcluster
	ensure_packages(['default-jre'], { ensure => present })

	Package { 'filebeat':
		ensure   => present,
	}

	File { '/etc/filebeat/filebeat.yml':
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		mode    => '0600',
		content => template("${module_name}/filebeat.yml.erb"),
		require => Package['filebeat'],
		notify  => Service['filebeat'],
	}

	Service { 'filebeat':
		ensure  => 'running',
		enable => 'true',
	}

}

