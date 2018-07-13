id = 'cronic'

resource_name :cronic_setup
property :name, String, name_property: true
default_action :install

action :source do
  directory node[id]['src_dir'] do
    mode 0775
    action :create
  end

  %w(
    cronic
    Makefile
  ).each do |file_name|
    cookbook_file ::File.join(node[id]['src_dir'], file_name) do
      source file_name
      mode 0644
      action :create
    end
  end
end

action :install do
  cronic_setup new_resource.name do
    action :source
  end

  execute 'install cronic' do
    command 'make install'
    cwd node[id]['src_dir']
    action :run
  end

  node.run_state['cronic_installed'] = true
  node.run_state['cronic_command'] = '/usr/local/bin/cronic'
end

action :uninstall do
  cronic_setup new_resource.name do
    action :source
  end

  execute 'uninstall cronic' do
    command 'make uninstall'
    cwd node[id]['src_dir']
    action :run
  end

  node.run_state['cronic_installed'] = false
end
