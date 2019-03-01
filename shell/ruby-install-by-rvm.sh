#!/usr/bash
# This script is for change ruby gem source to taobao in China.
# Dec.17, 2015 first release by https://github.com/wikinee
echo "===================Attention Before=============================="
echo "Install Progress will you openssl, and wget,please use homebrew install it"
echo "try finished command: brew install openssl wget"
echo "===================Ruby Version Manager======================"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 | curl -sSL https://get.rvm.io | bash -s stable
source ~/.bashrc
source ~/.bash_profile
if [ -f "$HOME/.zshrc" ]; then
  source $HOME/.zshrc
fi
echo "Use the RubyChina rvm and rubygems repalced default? Enter yes or input other skip"
read use_rubychina_ruby
if [ "use_rubychina_ruby" == "" ]; then
  echo "===================Ruby Version Manager Mirror==================="
  echo "Try to use ruby china rvm mirrors..."
  echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db
  echo "Input you want get Ruby Version, check list and q to quit; default 2.2.1(Enter) or like x.x.x you like: "
  rvm list known
  read ruby_version

  rvm install ${ruby_version:-2.2.1}
  rvm use ${ruby_version:-2.2.1} --default
  echo "===================RubyGems Mirror==========================="
  gem sources --remove https://rubygems.org/
  gem sources --remove https://ruby.taobao.org/
  gem sources --add https://gems.ruby-china.com
  echo "please make sure only have https://gems.ruby-china.com"
fi  
gem sources -l
echo "usage like this: $ gem install rails"
echo "==================Ruby Develop Finished======================"
exit 0