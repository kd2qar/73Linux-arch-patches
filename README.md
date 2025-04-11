# 73Linux-arch-patches
Patches for KM4ACK's 73Linux to accomodate other architectures

This was an outgrowth of work done to identify a problem installing 73Linux on K3TCD's Raspberrypi.

The problem was that the 73Linux scripts did not recognize the architecture of a Raspberry PI B Rev 2 and did not fail gracefully when it encountered an unexpected device.
The obvious symptom was that the dialog with the list of applications came up empty. 
This fix is specific to the armv6l architecture (Raspberry Pi Model B Rev 2). However, you could easilly make similar modifications for other devices.
These patches are specific the version of 73Linux downloaded on 4/11/25. Chances are good that both files may have changed
Files Patched:

	73.sh
	bin/set-enviroment.sh

Use these as a pattern to address a similar problem for your unsupported architecture.

Discussion:

the scripts use case statements with data parsed from the 'lscpu' command.
It only looks at 3 architectures and does not fail gracefully when another architecture is found.

It results in the APPSFILES environment variable is empty after not matching the architecture.
The script keeps going with this empty variable and is unable to find any of the files it needs to list and install the applications.


