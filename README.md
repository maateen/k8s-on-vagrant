# K8S on Vagrant

## Quick Start

To start the cluster:

```bash
$ make up
```

To pause the cluster:

```bash
$ make halt
```

To shut down the cluster:

```bash
$ make down
```

Or,

```bash
$ cd master-1
$ vagrunt up
$ cd worker-1
$ vagrunt up
$ cd worker-2
$ vagrunt up
```

Do not forget to change the K8S join token in `bootstrap.sh` file at worker-1 and worker-2.