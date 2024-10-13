# ASSH - Augmented SSH
**Automated, Self-Propagating Shell Enhancements for Every SSH Session**


## Usage

### Setup
1. **Copy or Link Directory**  
   Copy or symlink the ASSH directory to `~/.assh.d`:

2. **Edit .bashrc**  
   To ensure ASSH and all `~/.assh*/bin/` are available add this to ~/.bashrc:

```
# ASSH: load the last alphabetically ordered ~/assh*/.asshrc
export LH=~/.assh.d
file=$(ls -d ~/.assh*/.asshrc 2>/dev/null | sort | tail -n 1)
[[ -f $file ]] && source "$file" || true
```

3. **Automatic Transfer to Server**  
   When you connect to a server, the contents of `~/.assh.d` are automatically
   copied, including the ASSH script, allowing you to use ASSH directly from
   that server to other servers.

### Using ASSH
ASSH behaves just like SSH but with added convenience and functionality:

- **Standard Connection**  
  Connect to a server as you would with SSH:  
  assh user@host

- **Cascading Connections**  
  Once connected, you can use ASSH from the server to connect to another server:  
  assh user@host2

- **Quick Access to Commands**  
  Any executable scripts in the `bin` subdirectory are automatically available.
  I use filenames prefixed by `,` for easy lookup with ,<tab><tab>

    ,help

- **Reverse Port Forwarding with Copying**  
  Using assh -R host sets up reverse port forwarding, enabling you to copy
  files directly from the connected servers. You only use -R when you first
  start assh and the ,copy command will be available from all hosts.

    ,copy <path>

- **No login messages**  
  By default, you get no motd messages. This behavior is controlled by the
  .hushlogin and .hushassh files. Removing these files will show you the
  default login messages or a customized version.

  This is very useful in an enterprise setting where you have various servers
  that give you information you can't really use for anything.

  The customized version you get by deleting .hushassh allows you to better see
  the server's status and to also get a unified message that you can customize
  as you see fit.

- **Endless customizations**  
  You can customize the .sshrc for generic usage, add custom functionality for
  each server you log in to, or for groups of servers.

  ~/.assh.d is just the main directory... all ~/.assh* directories get loaded
  in alphabetical order and combined on the server you assh into. This way you
  can have group settings but can also customize your own, overwriting with
  custom functionality while also keeping

- **100% compatibility, 100% code is bash**  
  All code is bash so it can execute without problems on any server. Other
  dependencies are widely available: openssl, cut, cat, tr, sed Because the
  code is bash you can review it and be sure it does what it says.

- **Extensibility**  
  These usage examples are just simplified use cases but there's a lot more
  that can be done, especially in the enterprise realm:
  - logging input/output of all the assh sessions
  - yubikey plugged into your laptop can be used on the server
  - plugin system for complex functionality
  - encryption is baked in and easily extended to other uses
  - group/team features, pastebin sharing
  - server health and notifications
  - intrusion detection
  - safe static binary execution from a trusted location
  - ... all with on-the-fly automatic setup and no modifications on the servers

ASSH extends SSH’s functionality without altering the familiar workflow,
streamlining multi-server connections and file operations being especially
useful for workflows with jump hosts, bastion servers, and multiple users
using the same accounts on the servers.

You get your personal configuration and scripts automatically even if it's the
first time you logged into that server. All the configurations are temporary
and get removed automatically when the connection breaks or you log out.

