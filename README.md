Mobile development assignment 2
===============================

Main problem encountered during the implementation: **Swift**.
Honestly, it's just another Java/C# clone done for iStuff ecosystem.
One of issues I struggled a bit with was the **dumb type inference system**
which failed to infer types for some expressions which I subsequently had to rewrite.
Additionally, the **string implementation is kinda wacky** --- as I was running swift
under a GNU/Linux system, Strings had to be converted to Unix ones before using
String with format (which, I suppose, is caused by this constructor using libc's [v]snprintf under the hood).
Overall impression: **meh**.
