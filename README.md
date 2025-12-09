# Asimov Builder

This is a copy of [Void Builder](https://github.com/voideditor/void-builder), which is a fork of [VSCodium](https://github.com/vscodium/vscodium).

## How to use locally

Unlike VSCodium and Void Builder, this can be used for local builds as well. At the moment only MacOS is supported.

### Requirements

Make sure you have nodejs, npm and jq on your system.

Then all you do is

```sh
./scripts/stable-macos.sh ## for Apple Silicon
VSCODE_ARCH=x64 ./scripts/stable-macos.sh ## for Intel
```
 