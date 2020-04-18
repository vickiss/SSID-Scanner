# SSID-Scanner

Scan and collect SSID of all networks around your Mac 🕸️

Usage:

Just run it, or pass the only argument to set attempt times (default is 10).

```bash
$ ./scan.sh
📶 scanner started
   #1 - ☑️  got 115, best result for now
   #2 - ☑️  got 145, best result for now
   #3 - ☑️  got 163, best result for now
   #4 - ☑️  got 167, best result for now
   #5 - ☑️  got 176, best result for now
   #6 - 🔄 got 176, not good enough
   #7 - 🔄 got 176, not good enough
   #8 - 🔄 got 166, not good enough
   #9 - 🔄 got 163, not good enough
  #10 - 🔄 got 164, not good enough
📶 scanner ended

$ ./scan.sh 3
📶 scanner started
   #1 - ☑️  got 107, best result for now
   #2 - ☑️  got 131, best result for now
   #3 - ☑️  got 140, best result for now
📶 scanner ended
```

Reference:

- http://qilin.hisown.com/articles/11208ellpA.html
