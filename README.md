#DBM Feenix 2.4.3 - Outlands
I worked on adjusting the DBM Timers for Feenix 2.4.3 Archangel Server in my time playing on there, since I've stopped doing so there will most likely be not that much of a progress from now on but feel free to keep working on my code or at least report Issues here on GitHub (if you support enough Material for me to fix things without playing myself I might do that).

<br \>
<a href="https://github.com/MOUZU/DBM-Feenix-2.4.3---Outlands/releases">Download latest Release</a><br \>
<a href="http://www.wow-one.com/forum/topic/94594-243-dbm-adjusted-for-feenix/">WOW-ONE.com Forum Thread</a>

#Changelist
For people who aren't into coding and doesn't want to check the Changes in Detail I'll list here the major changes made prior to this first GitHub upload:

HKM:
- changed the timer for the first whirlwind from 58s to 29s and the following whirlwinds from 55s to 34s (from my research it can not be predicted 100% accurate)
- added a timer for the first Felhunter (10s after combat start), changed the timer from 48.5s to 37s for others

Gruul: (untested)
- changed the locale to trigger the fight from "Come.... and die." to "Come... and die."
- changed the timer for the first ground slam from 38s to 34s
- changed the timer for the next ground slams from 76s to 71s and changed its trigger since the emote is not being used on feenix
- changed the "Silence" timer to "Possible Silence" and lowered the value from 38s to 20s (after a Silence cast), the first silence from 108s to 115s

Magtheridon: (UNFINISHED)
- didnt seem to trigger the phase1 correct when youve already wiped. Added another trigger which should do the work.
- changed the Timer for Blast Nova to 67s for the first one and 69s for the others and a mechanism which delays the blast nova after phase3 trigger by 9s
- added sync for phase triggering
