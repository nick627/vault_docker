# Don't remove default policy
path "empty/" {
    capabilities = ["list"]
}

# Allow a token to look up its own capabilities on a path
path "sys/capabilities-self" {
    capabilities = ["update"]
}

# Allow tokens to look up their own properties
path "auth/token/lookup-self" {
    capabilities = ["read"]
}
