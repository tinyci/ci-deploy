# Ansible tooling to deploy tinyCI

This allows tinyCI to be deployed by ansible.

It currently assumes there is one host to run the tinyCI agents and UI on, and
the rest for runners. Expect this to change as soon as we get time to resolve
it.

## Configuring it

**Please be sure to customize `group_vars/all`!!** It contains multiple issues
around security you must change, including oauth information.

Additionally, most vars have meaningful properties you can set directly in
inventory to influence their installation.

There are two paths you must populate:

- `roles/release/files/release.tar.gz` -- the version of the tinyCI release;
  once real releases exist, we will just download this from github. **Create the
  directory first.**
- `roles/certificates/files/ca` -- must be populated with the CA files present
  in your group. You can run the `make-certificates.sh` bash tool to make the
  default certificates with [mkcert](https://github.com/FiloSottile/mkcert).
  Please note all certs that tinyCI uses must be **ecdsa based, not RSA**.

## Running it

First things first, be sure to customize the `inventory` file with your
environment settings.

```
$ ansible-playbook -kK -i inventory playbook.yml
```

## Author

Erik Hollensbe <github@hollensbe.org>
