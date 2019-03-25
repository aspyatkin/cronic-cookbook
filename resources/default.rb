resource_name :cronic
property :name, String, name_property: true
property :src_dir, String, default: '/opt/cronic'
default_action :install

action :source do
  directory new_resource.src_dir do
    mode 0o775
    action :create
  end

  %w[cronic Makefile].each do |file_name|
    cookbook_file ::File.join(new_resource.src_dir, file_name) do
      cookbook 'cronic'
      source file_name
      mode 0o644
      action :create
    end
  end
end

action :purge do
  directory new_resource.src_dir do
    recursive true
    action :delete
  end
end

action :install do
  cronic new_resource.name do
    src_dir new_resource.src_dir
    action :source
  end

  execute 'install cronic' do
    command 'make install'
    cwd new_resource.src_dir
    action :run
  end

  node.run_state['cronic'] = {}
  node.run_state['cronic']['installed'] = true
  node.run_state['cronic']['command'] = '/usr/local/bin/cronic'
end

action :uninstall do
  cronic new_resource.name do
    src_dir new_resource.src_dir
    action :source
  end

  execute 'uninstall cronic' do
    command 'make uninstall'
    cwd new_resource.src_dir
    action :run
  end

  cronic new_resource.name do
    src_dir new_resource.src_dir
    action :purge
  end

  node.run_state['cronic'] = {}
  node.run_state['cronic']['installed'] = false
  node.run_state['cronic']['command'] = nil
end
