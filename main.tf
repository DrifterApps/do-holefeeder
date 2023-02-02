# DO infrastructure resources

terraform {
  cloud {
    organization = "drifterapps"

    workspaces {
      name = "gh-actions-drifterapps-app"
    }
  }
}
