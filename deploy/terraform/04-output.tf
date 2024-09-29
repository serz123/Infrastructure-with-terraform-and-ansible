
resource "local_file" "ansible_inventory"{
  content = templatefile("./templates/inventory.tmpl",
  {
    webserver_ip = openstack_networking_floatingip_v2.web_float_ip.address
    database_server_ip = openstack_networking_floatingip_v2.database_float_ip.address
  }
  )
  filename = "../ansible/inventory"
}

resource "local_file" "ansible_all_group_var"{
  content = templatefile("./templates/all.tmpl",
  {
    apache_port = var.web_listening_port
    database_port = var.database_listening_port
  }
  )
  filename = "../ansible/group_vars/all.yml"
}

output "web_server_public_ip" {
  value = openstack_networking_floatingip_v2.web_float_ip.address
  sensitive = false
}

output "web_server_private_ip" {
  value = openstack_compute_instance_v2.server.access_ip_v4
  sensitive = false
}

output "database_server_public_ip" {
  value = openstack_networking_floatingip_v2.database_float_ip.address
  sensitive = false
}

output "database_server_private_ip" {
  value = openstack_compute_instance_v2.server-dbs.access_ip_v4
  sensitive = false
}

resource "null_resource" "wait_ssh" {
 
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file(var.identity_file)}"
    host     = openstack_networking_floatingip_v2.web_float_ip.address
  }
  provisioner "remote-exec" {
    inline = [
      "echo hello from `hostname`"
    ]
  }
    triggers = {
    always_run = "${timestamp()}"
  }
   depends_on = [local_file.ansible_inventory, openstack_compute_floatingip_associate_v2.web_ip_server, openstack_networking_router_interface_v2.router_interface]
}
