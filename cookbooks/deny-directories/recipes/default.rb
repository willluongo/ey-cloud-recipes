if ['app_master', 'app', 'solo'].include?(node[:instance_role])
	node[:applications].each do |app, data|
		remote_file "/data/nginx/servers/#{app}/custom.conf" do
			source "custom.conf"
			owner node[:owner_name]
			group node[:owner_name]
			mode 0644
		end
		remote_file "/data/nginx/servers/#{app}/ssl/custom.conf" do
			source "custom.conf"
			owner node[:owner_name]
			group node[:owner_name]
			mode 0644
			only_if { ::File.exists?("/data/nginx/servers/#{app}/ssl/") }
		end
	end

	execute "Reload nginx config" do
		command "sudo /etc/init.d/nginx reload"
	end
end
