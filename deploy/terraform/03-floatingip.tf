resource "openstack_networking_floatingip_v2" "web_float_ip" {
  pool = "public"
}

resource "openstack_networking_floatingip_v2" "database_float_ip" {
  pool = "public"
}

# associate public IP
resource "openstack_compute_floatingip_associate_v2" "web_ip_server" {
  floating_ip = openstack_networking_floatingip_v2.web_float_ip.address
  instance_id = openstack_compute_instance_v2.server.id
  depends_on = [
    openstack_compute_instance_v2.server, openstack_networking_floatingip_v2.web_float_ip
  ]
}

resource "openstack_compute_floatingip_associate_v2" "database_ip_server" {
  floating_ip = openstack_networking_floatingip_v2.database_float_ip.address
  instance_id = openstack_compute_instance_v2.server-dbs.id
  depends_on = [
    openstack_compute_instance_v2.server-dbs, openstack_networking_floatingip_v2.database_float_ip
  ]
}
