# Setting up subsonic please see http://www.subsonic.org/pages/installation.jsp#debian
class subsonic {

  $version = '6.1.3'

  $url= 'https://s3-eu-west-1.amazonaws.com/subsonic-public/download'
  
  $deb  = "subsonic-${version}.deb"

  exec{'download subsonic deb':
    command => "wget -O /usr/src/${deb} ${url}/${deb}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    timeout => '1200',
    unless  => "test -f /usr/src/${deb}"
  } ->

  package{'openjdk-8-jre':
    ensure  => present
  } ->

  package{'subsonic':
    ensure   => latest,
    source   => "/usr/src/${deb}",
    provider => dpkg,
  } ~>

  service{'subsonic':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

}
