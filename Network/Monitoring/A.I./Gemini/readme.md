https://share.google/aimode/aW9k5SfClsj8i3zaq
https://share.google/aimode/Jyo8PsxsztjhzCHwR
https://share.google/aimode/adxOhIN5NbUtjun8I
https://share.google/aimode/QIsbbnOcdd1NU3XG8
https://share.google/aimode/1dekYjVs5nLPYBRu1

# Query.Chain:
- android monitor hotspot network usage
- I would like a realtime bandwidth usage meter for a hotspot. On the connected Wifi Client device I have a long-running download process that tends to freeze. I should be able to detect if it has frozen based on bandwidth used decreasing.
- The client device is a Chromebook, and the process is the integrated Linux terminal "Development Environment" built in to Chromebooks. How would monitor it?
- Is there any way to do it in Chromes native crosh or root shell? The problem is the first "initialization" of Terminal is freezing. So I never get to the point where apt-get is available.
- Is there any folder on ChromeOS where I can write a "temporary" file? Such as for making a bash.sh script?
- I did `cat /proc/net/dev` and got some interface called "mlan0". What is that?
- Thank You Gemini! You were a huge help. I have gotten it working, and though slow it appears the Terminal download is working!
- One final question: Is it possible to "Pause" a Terminal initial setup? What would happen if the Wifi were to get interrupted? Does it have to restart from zero? Does it timeout?

# Command
monitor()  
`while true; do awk '/wlan0/ {print "Received: " $2/1024 " KB  |  Sent: " $10/1024 " KB"}' /proc/net/dev; sleep 2; done`

check_interfaces()  
`cat /proc/net/dev`
