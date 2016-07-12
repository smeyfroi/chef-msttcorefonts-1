package 'fontconfig'

#--------
# enable multiverse
#--------
apt_repository 'security-ubuntu-multiverse' do
  uri          'http://security.ubuntu.com/ubuntu'
  distribution 'trusty-security'
  components   ['multiverse']
  deb_src      true
end

#--------
# install mscorefonts
#--------
# from http://askubuntu.com/questions/16225/how-can-i-accept-microsoft-eula-agreement-for-ttf-mscorefonts-installer
bash 'run ttf-mscorefonts-installer' do
  user 'root'
  code <<-EOS
  dpkg --configure -a
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  apt-get install -y ttf-mscorefonts-installer >/dev/null
  EOS
  not_if 'test -e /usr/share/fonts/truetype/msttcorefonts/arial.ttf'
  notifies :run, 'execute[regenerate fontcache]'
end
