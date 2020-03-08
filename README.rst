================================
Wireguard on Windows
================================
:by: harland.coles@energy-x.com
:dt: 2020-03-06
:licence: CC-BY


Wireguard on Windows
=========================

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

2. Copy (or git clone) repo files into, say, C:\wireguard\

3. Update configuration files and batch scripts
	- wg0_server.conf -- your server's adapter / interface config
		- note: name of file becomes adapter name (without '.conf')
	- wireguard_start.bat
	- wireguard_stop.bat

4. You may test drive the config in 'wg0_server.conf' by importing with the wireguard GUI and activating.


Usage
---------------
Start server with batch script 'wireguard_start.bat'
Stop server with batch script 'wireguard_stop.bat'


Deployment
---------------
May setup scheduled task(s) to run start/stop batch script


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
