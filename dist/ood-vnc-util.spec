%define app_path /www/ood/apps/sys/
%define app_name ood-vnc

Name:           ood-vnc-util
Version:        3
Release:        1%{?dist}
Summary:        Open on Demand vnc utils

BuildArch:      noarch

License:        MIT
Source:         %{name}-%{version}.tar.bz2

Requires:       ondemand
Requires:       ood-util
Requires:       ood-initializers
Obsoletes:      ood-virtualgl

# Disable debuginfo
%global debug_package %{nil}

# User will be prompted if desktop files are not executable.
# Disable brp-mangle-shebangs as it removes executable bit since the shebang does not exist.
%global __brp_mangle_shebangs_exclude_from ^.*\.desktop.erb$

%description
Open on Demand vnc utils

%prep
%setup -q

%build

%install

%__install -m 0755 -d %{buildroot}%{_localstatedir}%{app_path}%{app_name}/template/{apps,bin,desktops}
%__install -m 0755 -d %{buildroot}%{_localstatedir}%{app_path}%{app_name}/{applications,icons,local}
%__install -m 0755 -D template/bin/* %{buildroot}%{_localstatedir}%{app_path}%{app_name}/template/bin/
%__install -m 0755 -D applications/*.desktop %{buildroot}%{_localstatedir}%{app_path}%{app_name}/applications
%__install -m 0644 -D icons/*.png %{buildroot}%{_localstatedir}%{app_path}%{app_name}/icons/
# TODO: remove unused desktops
%__install -m 0755 -D template/desktops/*.sh.erb %{buildroot}%{_localstatedir}%{app_path}%{app_name}/template/desktops/
%__install -m 0755 -D template/*.erb %{buildroot}%{_localstatedir}%{app_path}%{app_name}/template/
%__install -m 0755 -D local/*.erb %{buildroot}%{_localstatedir}%{app_path}%{app_name}/local/
%__install -m 0644 manifest.yml *.js *.erb README.md LICENSE %{buildroot}%{_localstatedir}%{app_path}%{app_name}/
echo %{version}-%{release} > %{buildroot}%{_localstatedir}%{app_path}%{app_name}/VERSION

%files

%{_localstatedir}%{app_path}%{app_name}

%changelog
* Thu Feb 23 2023 Sami Ilvonen <sami.ilvonen@csc.fi>
- Initial version
