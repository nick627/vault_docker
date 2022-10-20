# All write
path "*" {
    capabilities = ["list", "read", "create", "update"]
}
# Deny _services
path "_services/*" {
    capabilities = ["deny"]
}
# Deny policies
path "/sys/policies/*" {
    capabilities = ["deny"]
}
# Deny auth
path "auth/*" {
    capabilities = ["deny"]
}
