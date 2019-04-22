variable ami_name { default = "ami-0511f039a8ee0c3de" }
variable node_instance_type { default = "t2.medium" }
variable master_instance_type { default = "t2.small" }
variable cluster_name {}
variable lb_type { default = "Internal" }
variable owner { default = "Samson Gudise" }
variable team { default = "DevOps" }
variable kops_state_store {}
variable oidcClientID { default = "abcdefgh-12d4-1234-b58e-1234567890xyz" }
variable oidcIssuerURL { default = "https://sts.windows.net/abcdefgh-12d4-1234-b58e-987654345xzc/" }
variable oidcUsernameClaim { default = "upn" }
variable version { default = "1.11.8" }
variable apiaccess {
    type = "list"
    default = [ "0.0.0.0/0", "10.20.20.1/32" ]
}
variable sshaccess {
    type = "list"
    default = [ "0.0.0.0/0" ]
}

output "cluster_name" {
    value = "${var.cluster_name}"
}
output "lb_type" {
    value = "${var.lb_type}"
}
output "kops_state_store" {
    value = "${var.kops_state_store}"
}
output "owner" {
    value = "${var.owner}"
}
output "team" {
    value = "${var.team}"
}
output "ami_name" {
    value = "${var.ami_name}"
}
output "node_instance_type" {
    value = "${var.node_instance_type}"
}
output "master_instance_type" {
    value = "${var.master_instance_type}"
}
output "oidcClientID" {
    value = "${var.oidcClientID}"
}
output "oidcIssuerURL" {
    value = "${var.oidcIssuerURL}"
}
output "oidcUsernameClaim" {
    value = "${var.oidcUsernameClaim}"
}
output "version" {
    value = "${var.version}"
}
output "apiaccess" {
    value = "${var.apiaccess}"
}
output "sshaccess" {
    value = "${var.sshaccess}"
}