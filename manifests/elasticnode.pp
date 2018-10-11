class elkcluster::elasticnode (
    $elkcluster_name   = '',
    $elkcluster_nodes = '',
) {

	Package { 'default-jre': ensure => present }

    apt::source { "elasticsearch_deb_repo":
        location => "https://artifacts.elastic.co/packages/6.x/apt",
        key      => "D27D666CD88E42B4",
        repos    => "main",
        release  => "stable",
    }

	Package { 'elasticsearch': ensure => present }

	file { '/etc/elasticsearch/elasticsearch.yml':
        ensure  => file,
        owner   => 'root',
        group   => 'elasticsearch',
        mode    => '0664',
        content => template("${module_name}/elasticsearch.yml.erb"),
        require => Package['elasticsearch'],
    }




}

