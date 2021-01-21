data "template_file" "init_script" {
  template = file("scripts/init.cfg")
}

data "template_file" "shell_script" {
  template = file("scripts/setup.sh")
}

data "template_cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init_script.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell_script.rendered
  }
}

