package "apt"
#
apt_repository "rrepository" do
  uri "http://cran.md.tsukuba.ac.jp/bin/linux/ubuntu"
  distribution "precise/"
  #components ["all"]
  keyserver "keyserver.ubuntu.com"
  key "E084DAB9"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end
package "r-base"

# R version check script
cookbook_file '/home/vagrant/showversion.R' do
  source "showversion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end
# Bioconductor version check script
cookbook_file '/home/vagrant/showBioconductorVersion.R' do
  source "showBioconductorVersion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

# .Renviron
cookbook_file '/home/vagrant/.Renviron' do
  source ".Renviron"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
# .Rprofile
cookbook_file '/home/vagrant/.Rprofile' do
  source ".Rprofile"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

# R user library directory
directory "/home/vagrant/R/library" do
  owner "vagrant"
  group "vagrant"
  recursive true
  mode "0755"
  action :create
end

# for Bioconductor ALL package
package "libxml2-dev"
package "libcurl4-gnutls-dev"
package "pkg-config"
package "libgtkmm-2.4-dev"
package "libgsl0-dev"
package "libfftw3-dev"
package "libhdf4-dev"
package "libhdf5-serial-dev"
package "libtiff4-dev"
package "libgmp-dev"
package "libcairo2-dev"
package "openjdk-7-jdk"
package "libglu1-mesa-dev"
package "mesa-common-dev"
package "tk-dev"
package "ggobi"
package "jags"

# Bioconductor install script
cookbook_file '/home/vagrant/installBioconductor.R' do
  source "installBioconductor.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

execute "R Java reconf" do
  command "R CMD javareconf"
  action :run
end

# install Bioconductor
execute "install Bioconductor" do
  command "R CMD BATCH /home/vagrant/installBioconductor.R"
  action :run
end
