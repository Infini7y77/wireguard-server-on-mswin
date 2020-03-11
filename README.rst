
Wireguard on Windows
=========================
:dt: 2020-03-06
:licence: CC-BY

Introduction
---------------
Use wireguard_ as a server (multi client endpoint) on MS Windows OS

Based on excellent how-to_ on henrychang.ca

This package tries to simplify the config and setup needed to run wireguard as a server on windows, into a start and stop script


Reference
---------------
.. _how-to: https://www.henrychang.ca/how-to-setup-wireguard-vpn-server-on-windows/
.. _wireguard: https://wireguard.com


Install
---------------
1. Download and Install latest windows package from wireguard_, at: https://download.wireguard.com/windows-client/

2. Copy (or git clone) repo files into, say, ``C:\wireguard\``

3. **Update configuration files and batch scripts**
	- wg0_server.conf -- your server's adapter / interface config
		- note: name of file becomes adapter name (without '.conf')
	- wireguard_start.bat
	- wireguard_stop.bat

4. You may test drive the config in 'wg0_server.conf' by importing with the wireguard GUI and activating.


Usage
---------------
- Start server with batch script 'wireguard_start.bat'
- Stop server with batch script 'wireguard_stop.bat'
- Note: *Batch scripts need to be run with administrator privilege*


Deployment
---------------
May setup scheduled task(s) to run start/stop batch script


BUGS
---------------
An odd bug has crept in, at first everything worked well, but now the ICS fails
where it is unable to share the 'private' side of the share,
that is the wireguard adapter will not 'attach' to 'public' ethernet adapter.
Looking in ethernet adapter properties, sharing is enabled, but wireguard adapter not selected.
Looking in wireguard adapter properties, under IPv4 item, IP and subnet is blank.
However looking at wireguard adapter Status details... IP is set correctly.
Not sure if a wireguard.exe issue on adapter setup, or a Windows bug on starting and stopping too many times.
**YMMV**.

Licence
---------------
https://opensource.org/licenses/MIT with Copyright 2020 H.R.Coles


Acknowledgments
----------------







Footnotes
=========================
.. _link: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html

.. kate: syntax RestructuredText HRC;
.. eof
