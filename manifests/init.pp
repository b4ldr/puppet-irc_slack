# @summary install https://github.com/insomniacslk/irc-slack
class irc_slack (
    Stdlib::Unixpath    $source_dir  = '/usr/local/src/irc-slack',
    Stdlib::Unixpath    $home_dir    = '/var/lib/irc-slack',
    String              $user        = 'irc-slack',
    Stdlib::IP::Address $listen      = '127.0.0.1',
    Stdlib::Port        $port        = 6666,
    Stdlib::Fqdn        $server_name = $facts['networking']['fqdn'],
    Stdlib::HTTPUrl     $source      = 'https://github.com/insomniacslk/irc-slack.git',
    String              $branch      = 'master',
    Irc_slack::Loglevel $log_level   = 'warn',
) {
    ensure_packages(['golang'])
    user {$user:
        ensure     => present,
        home       => $home_dir,
        managehome => true,
        shell      => '/usr/sbin/nologin',
        system     => true,
    }
    file{$source_dir:
        ensure => directory,
        owner  => $user,
    }
    vcsrepo {$source_dir:
        ensure   => latest,
        source   => $source,
        provider => git,
        user     => $user,
        revision => $branch,
        require  => File[$source_dir],
    }
    exec{'go build':
        path        => '/usr/bin',
        user        => $user,
        cwd         => $source_dir,
        environment => [
            "GOCACHE=${home_dir}/.cache/go-build",
            "GOPATH=${home_dir}/go",
        ],
        creates     => "${source_dir}/irc-slack",
        subscribe   => Vcsrepo[$source_dir],
        notify      => Service['irc-slack.service'],
    }
    file{'/usr/local/bin/irc-slack':
        ensure  => link,
        target  => "${source_dir}/irc-slack",
        require => Exec['go build']
    }
    systemd::unit_file{'irc-slack.service':
        enable  => true,
        active  => true,
        content => template('irc_slack/irc-slack.service.erb'),
    }
}
