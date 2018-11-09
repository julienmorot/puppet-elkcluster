class elkcluster::kibana (
    $elkcluster_nodes  = ['localhost'],
	$elkcluster_endpoint = "http://localhost:9200",
) {

	include ::elkcluster
	ensure_packages(['default-jre'], { ensure => present })

	Package { 'kibana':
		ensure   => present,
	}

	File { '/etc/kibana/kibana.yml':
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		content => template("${module_name}/kibana.yml.erb"),
		require => Package['kibana'],
		notify  => Service['kibana'],
	}

	Service { 'kibana':
		ensure  => 'running',
		enable => 'true',
	}

}

