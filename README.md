# Stream metadata for RHEL CoreOS

This repository contains a "CoreOS stream metadata" file
which implements https://github.com/openshift/os/issues/477
which is a subset of the larger bootimage enhancement:
https://github.com/openshift/enhancements/pull/201

# Updating this metadata

The all purpose CoreOS building and testing tool is [coreos-assembler](https://github.com/coreos/coreos-assembler/).  It contains the `plume` command.

To update the bootimage for one or more architectures, use e.g.

```
$ plume cosa2stream --target rhcos-4.8.json --distro rhcos  x86_64=48.83.202102230316-0 s390x=47.83.202102090311-0 ppc64le=47.83.202102091015-0
```

### Origin of this data

The initial file `rhcos-4.8.json` was generated this way:

```
$ plume cosa2stream --name rhcos-4.8 --distro rhcos  x86_64=48.83.202102230316-0 s390x=47.83.202102090311-0 ppc64le=47.83.202102091015-0 > rhcos-4.8.json
```

But the plume `--target` command is designed to read and write an existing file, so there shouldn't generally be a need to use this invocation again.

