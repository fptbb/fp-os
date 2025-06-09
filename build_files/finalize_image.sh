#!/bin/bash
set -ouex pipefail

# Commit and lint container
ostree container commit
bootc container lint
