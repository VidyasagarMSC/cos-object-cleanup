resource ibm_resource_instance cos {
  name              = "${var.basename}-cos"
  resource_group_id = var.resource_group_id
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  tags              = concat(var.tags, ["service"])
}

resource ibm_resource_key cos_key {
  name                 = "${var.basename}-cos-key"
  resource_instance_id = ibm_resource_instance.cos.id
  role                 = "Writer"

  parameters = {
    service-endpoints = "private"
    HMAC = true
  }
}

resource ibm_cos_bucket sink_bucket {
  bucket_name          = "${var.basename}-sink-bucket-test1"
  key_protect          = data.terraform_remote_state.kms.outputs.key.crn
  resource_instance_id = ibm_resource_instance.cos.id
  region_location      = var.region
  storage_class        = "smart"
}

resource null_resource delete_objects {
  triggers = {
    ACCESS_KEY             = ibm_resource_key.cos_key.credentials["cos_hmac_keys.access_key_id"]
    SECRET_ACCESS_KEY      = ibm_resource_key.cos_key.credentials["cos_hmac_keys.secret_access_key"]
    COS_REGION             = var.region
    COS_BUCKET_NAME        = ibm_cos_bucket.sink_bucket.bucket_name
  }
  provisioner "local-exec" {
    when = destroy
    command = "./delete-cos-objects.sh ${self.triggers.COS_REGION} ${self.triggers.ACCESS_KEY} ${self.triggers.SECRET_ACCESS_KEY} ${self.triggers.COS_BUCKET_NAME} "
  }
  depends_on = [ibm_resource_key.cos_key,ibm_cos_bucket.sink_bucket]
}
