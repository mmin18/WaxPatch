## Wax Loader
Mutated version of Wax (https://github.com/probablycorey/wax/)

Support method override and direct method call from Obj-C code, which gives you the ability to dynamically change the behavior of a running iOS application.
### Tutorial
The patch is a zip file contains patch.lua and other lua codes. The sample code can be found at /patch folder.

The sample iOS project loads the patch from a url (which you probably want to change in AppDelegate.m) before launch.

The Original.png and Patched.png shows the difference.
### Issue
The mutated version of wax leaks when call method directly from Obj-C!!!

The issue is located at wax_instance.m, TODO mark.
