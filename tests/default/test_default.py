def test_super_mediator_version(host):
    version = "1.11.0"
    command = r"""LD_LIBRARY_PATH=/netsa/lib:$LD_LIBRARY_PATH \
                 PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/netsa/lib/pkgconfig \
                 /netsa/bin/super_mediator --version 2>&1 | \
                 head -n1 | egrep -o '([0-9]{1,}\.)+[0-9]{1,}'"""
    cmd = host.run(command)

    assert version in cmd.stdout
