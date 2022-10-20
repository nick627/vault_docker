# All write
path "*" {
    capabilities = ["list", "read", "create", "update"]
}
# Deny policies
path "/sys/policies/*" {
    capabilities = ["deny"]
}
# Deny auth
path "auth/*" {
    capabilities = ["deny"]
}
