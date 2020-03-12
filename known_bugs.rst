===================
Known Bugs
===================

MS Windows
==============

Net Connection Sharing Issue
-------------------------------
An odd bug has crept in, at first everything worked well, but now the ICS fails
where it is unable to share the 'private' side of the share,
that is the wireguard adapter will not 'attach' to 'public' ethernet adapter.
Getting this error in batch run log::
	Exception calling "EnableSharing" with "1" argument(s): "An event was unable to invoke any of the subscribers (Exception from HRESULT: 0x80040201)"

Looking in ethernet adapter properties, sharing is enabled, but wireguard adapter not selected.
Solved this, for now, maybe...
After running the start stript and getting error above,
go into ethernet adapter properties, select Sharing tab, and use dropdown to select 'private' adapter (eg. wg0_server),
then uncheck "Allow other network users to connect through [...]", and click [OK].
No run start script again, and seems to repair itself, ie no error on share setup.
**YMMV**.

.. eof
