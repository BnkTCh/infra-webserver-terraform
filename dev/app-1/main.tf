module "networking" {
  source = "../../modules/aws/networking"
  ec2_instance1 = module.compute.ec2_instance1_id
  ec2_instance2 = module.compute.ec2_instance2_id
}

module "compute" {
  source = "../../modules/aws/compute"

  sg_pvt = module.networking.sg_pvt_id
  sg_pub = module.networking.sg_pub_id
  sn_pvt_1a = module.networking.sn-pvt-1a-id
  sn_pvt_2b = module.networking.sn-pvt-2b-id
  sn_pub_1a = module.networking.sn-pub-1a-id
  sn_pub_2b = module.networking.sn-pub-2b-id

}