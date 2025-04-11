# 73Linux-arch-patches
Patches for KM4ACK's 73Linux to accomodate other architectures

This was an outgrowth of work done to identify a problem installing 73Linux on K3TCD's Raspberrypi.

The problem was that the 73Linux scripts did not recognize the architecture of a Raspberry PI B Rev 2 and did not fail gracefully when it encountered an unexpected device.
The obvious symptom was that the dialog with the list of applications came up empty. 
This fix is specific to the armv6l architecture (Raspberry Pi Model B Rev 2). However, you could easilly make similar modifications for other devices.
Use these as a pattern to address a similar problem for your unsupported architecture.
