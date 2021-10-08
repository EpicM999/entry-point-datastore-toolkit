# entry-point-datastore-toolkit
My toolkit for messing with Entry Point's datastore


Hello fellow traveler! I have compiled the secret exploits I have made over the years and have decided to share them here on github. Previously, we could only attack the client and anything that cish gave power to the client with. However, due to a datastore leak caused by non other than Dart, we were able to gain permissions to QA powers.

# Unlocking full power
Shortly after the datastore leak, we went to work exploring the server side and were able to spoof the server into thinking we're Cishshato. Since Roblox gives the dev higher powers by default, we've been able to abuse this for remote code execution on the server, meaning that we can now do as we like. Not only does this mean more exploits such as anti-detect and ironman legend speedrun, but we're also able to destroy the datastores.

# Why we're giving it away
Originally, our plan was to either stay sutble until we decided a date was good enough to cause havok and mayhem on Entry Point, or to go loud and proud to destroy as much as we could in the shortest amount of time.

We've matured from our mindset then and have decided that the fate of Entry Point should be given to the general public.

# Can't someone just break the game?
While it is true, we've decided to limit the power of any user with this toolkit. There simply isn't any fun in allowing anyone to press a button and have everyone's operatives be deleted.

# How is it regulated?
To make sure that everyone who uses the toolkit doesn't have more power than us, we've added a second simpler pathway to executing code on the server. The server reads the code sent and removes anything that could break through the sandbox that has been set up. We abuse remotes in order to achieve this much simpler and yet limited path to remote code execution.

# Why is it all open source?
While we may be shooting ourselves in the foot, we decided against obfuscating the code for 2 reasons.

1) We are abusing Roblox's source code and anything that happens is out of the control of Cishshato
2) If any mistake or improvement can be made, anyone will be able to point it out. Volunteer work is held in high regards by us.

# What is the worst that can happen?
As far as we know, the sanbox we've made only allows for limited datastore edits.

The limits are as follows:
1) Only one value in the datastores can be edited every 5 - 10 seconds.
2) Any remote code sent that edits the datastores faster will act as a promise and will wait until the next request can be sent.
3) Lua's garbage collector cannot be altered.
4) Only the __index and __namecall metamethods can be altered.
5) xpcall() and ypcall() are prohibited from use.
6) Bytecode will not be ran by the server.

The true worst that can come out of this is one person's data being slightly modified every 5 - 10 seconds.
- Code can be terminated by the exploiter at will.
- When the exploiter leaves the game, the server code will stop running altogether.

# How can you contribute to the project?
Currently, the only contributions we're looking for are code auditors with advanced knowledge of Lua and Networking.
Until we upload the sandbox code to the repository, we will not be needing any contributions.
