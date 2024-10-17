# ASSH - Augmented SSH
**Automated, Self-Propagating Shell Enhancements for Every SSH Session**

ASSH extends your local shell environment to remote SSH sessions, applying
your local scripts and shell configs without the need for remote modifications.

## Key Features

- **Local Environment Replication**  
  Bring your `.bashrc`, and other local shell configs and scripts into
  remote sessions automatically. Enjoy the familiarity of your local setup,
  no matter which server you connect to.

- **Zero Remote Changes**  
  Keep remote servers clean and secure. ASSH doesn’t modify remote
  configurations or scripts, making it lightweight and unobtrusive.

- **Zero or Easy Setup**  
  ASSH is designed for simplicity. Configuration files are straightforward,
  allowing you to set up quickly and with minimal effort.

- **100% bash**  
  Written entirely in Bash for maximum portability across different systems
  and terminals.


## Usage

### Simple Setup

For a simple setup you could run this in your terminal:
```
git clone https://github.com/h2io/assh.git ~/.assh.d
```

Add this to your `.bashrc`:
```
export LH="${LH:-$(eval echo ${HOME}/.assh.d)}"
. "$LH/.asshrc" || echo "[assh] file not found"
```

### Development Setup
For development you could add this instead:
```
export LH="${LH:-$(eval echo ${HOME}/.assh.d)}"
. "$LH/.asshrc" || echo "[assh] file not found"

export XD=1                         # develop flag
export LU="${LU:-$(eval echo ~)}"
XF=$(ls -d $LU/.assh*/.asshrc 2>/dev/null | sort | tail -n 1)
[[ -f $XF ]] && . "$XF" || true
```

This will load the last alpabetically ordered `~/.assh*/.asshrc`.  
You probably don't need more than one but it's sometimes usefull.  
The develop flag now only refreshes ASSH version on PROMPT_COMMAND, for now.
  
**Automatic Transfer to Server**  
   When you connect to a server, the contents of `~/.assh*` are automatically  
   copied, including the ASSH script, allowing you to use ASSH directly from  
   that server to other servers.  

### Using ASSH
ASSH behaves just like SSH but with added convenience and functionality:  

- **Standard Connection**  
  Connect to a server as you would with SSH:  
  `assh user@host`

- **Cascading Connections**  
  Once connected, you can use ASSH from the server to connect to another server:  
  `assh user@host2`

- **Quick Access to Commands**  
  Any executable scripts in the `bin` subdirectory are automatically available.  
  I use filenames prefixed by `,` for easy lookup with `,<tab><tab>`  

    `,help`
    `,cheat`

- **Reverse Port Forwarding with Copying**  
  Using `assh -R host` sets up reverse port forwarding, enabling you to copy  
  files directly from the connected servers. You only use -R when you first  
  start assh and the ,copy command will be available from all hosts.  

    `,copy <path>`

- **ControlMaster by Default**  
  ASSH enables ControlMaster by default for faster multi-server connections.  
  Use `-M0` to disable or `-MX` to close the ControlMaster socket.  
  This ensures speed and control without lengthy CLI parameters.  

- **sudo support**  
  You can keep using your ASSH config even after you `sudo su`.  
  Just use `,su` and all the configurations and scripts are available to you.  

- **No login messages**  
  By default, you get no motd messages. This behavior is controlled by the  
  `.hushlogin` and `.hushassh` files. Removing these files will show you the  
  default login messages or a customized version.  

  This is very useful in an enterprise setting where you have various servers  
  that give you information you can't really use for anything.  

  The customized version you get by deleting `.hushassh` allows you to better see  
  the server's status and to also get a unified message that you can customize  
  as you see fit.  

- **Endless customizations**  
  You can customize the .sshrc for generic usage, add custom functionality for  
  each server you log in to, or for groups of servers.  

  `~/.assh.d` is just the main directory... all `~/.assh*` directories get loaded  
  in alphabetical order and combined on the server you assh into. This way you  
  can have group settings but can also customize your own, overwriting with  
  custom functionality while also keeping  

- **100% compatibility, 100% code is bash**  
  All code is bash so it can execute without problems on any server. Other  
  dependencies are widely available: openssl, cut, cat, tr, sed, ...  
  Because the code is bash you can review it and be sure it does what it says.  

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

