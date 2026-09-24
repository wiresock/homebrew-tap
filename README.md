# WireSock Homebrew tap

The official [Homebrew](https://brew.sh) tap for WireSock software.

## Alighieri

[Alighieri](https://github.com/wiresock/alighieri) is a lightweight SOCKS5
proxy with Dante-inspired configuration.

```sh
brew install wiresock/tap/alighieri
```

or, in two steps:

```sh
brew tap wiresock/tap
brew install alighieri
```

The formula builds the tagged release from source and needs Homebrew 6.0.22
or later, which `brew install` normally updates to automatically. If you have
disabled auto-update, run `brew update` first. Development builds of GitHub
`main` are available with `brew install --HEAD wiresock/tap/alighieri`.

On Intel Macs, Homebrew no longer publishes bottles
([Tier 3](https://docs.brew.sh/Support-Tiers#tier-3)), so the Rust toolchain
this formula builds with is itself compiled from source, which can take hours.
The prebuilt `x86_64-apple-darwin` archive on the
[Alighieri releases](https://github.com/wiresock/alighieri/releases) page is a
much faster alternative.

### Configuration

The default configuration is installed to:

```sh
"$(brew --prefix)/etc/alighieri.conf"
```

Check it with:

```sh
alighieri --check --config "$(brew --prefix)/etc/alighieri.conf"
```

### Running as a service

`brew services` runs Alighieri as a per-user service using that configuration:

```sh
brew services start alighieri
brew services list
brew services restart alighieri   # apply configuration changes
brew services stop alighieri
```

Logs are written to `"$(brew --prefix)/var/log/alighieri.log"`.

The hardened public-TLS LaunchDaemon (a dedicated `_alighieri` account under
`/opt/alighieri`) is a separate deployment that Homebrew does not manage. See
the Alighieri README for
[configuration](https://github.com/wiresock/alighieri#configuration) and
[macOS deployment](https://github.com/wiresock/alighieri#macos-console-and-launchd).

## Issues

Report packaging problems here, and Alighieri bugs in
[wiresock/alighieri](https://github.com/wiresock/alighieri/issues).
