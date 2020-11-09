output cos {
  value = ibm_resource_instance.cos
}

output cos_key {
  value = ibm_resource_key.cos_key
}

output bucket {
  value = ibm_cos_bucket.sink_bucket
}
