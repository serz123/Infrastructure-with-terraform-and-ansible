


resource "openstack_compute_instance_v2" "server" {

  flavor_id         = var.flavor_id
  key_pair          = var.key_name
  name              = "server-webA1"
  image_name        = var.server_image_name

#  security_groups   = ["${openstack_compute_secgroup_v2.ssh.id}"]
  security_groups   = [openstack_networking_secgroup_v2.ssh.name, openstack_networking_secgroup_v2.web.name]
  availability_zone = var.availability_zone
  depends_on = [
    openstack_networking_router_interface_v2.router_interface, openstack_networking_secgroup_v2.ssh
  ]
  network {
    name = openstack_networking_network_v2.network.name
  }
}

resource "openstack_compute_instance_v2" "server-dbs" {

  flavor_id         = var.flavor_id
  key_pair          = var.key_name
  name              = "server-databaseA1"
  image_name        = var.server_image_name

#  security_groups   = ["${openstack_compute_secgroup_v2.ssh.id}"]
  security_groups   = [openstack_networking_secgroup_v2.ssh.name, openstack_networking_secgroup_v2.database.name]
  availability_zone = var.availability_zone
  depends_on = [
    openstack_networking_router_interface_v2.router_interface, openstack_networking_secgroup_v2.ssh, openstack_networking_secgroup_v2.database
  ]
  network {
    name = openstack_networking_network_v2.network.name
  }
}