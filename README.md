# pack dev scripts

## The scripts I use most often are:
name | function
--- | ---
mkServer.sh | packages the server folder into a curseforge acceptable zip, if a version file exists ('dat.version') that will be used to adjust the zip filename
rawStart.sh | starts the server with a screen manager such as 'screen' making it easier to debug crash outputs as you can easily scroll the ssh tty console
makeSandwich.sh | puts the server jar in a wrapper that is managed by startServer.sh
startServer.sh | starts a master process that identifies screen and injects the actual server manager script into it
install.sh | on a brand new pack install, this will read CURRENT_INSTALLER and download that file with wget then start the forge install
getForge.sh | grabs a forge version and does what install.sh does, I've been starting to use this more and more.
versionit.sh | read dat.version if it exists, turns the version into an arrow, increments subversion and build, reads source.properties if it exists and creates a new server.properties containing the new version on the motd= line
wmenu.sh | discovers the master screen sessions running on an account and presents a console based menu to get into them
mkReport.sh | used to generate bug reports, provides a crash report reading option, and then a report generator which neatly bundles my notes along with the crash report and the latest log

## About this repository
The scripts are store in a folder hierarchy similar to how I use them in real life.
When you enter the scripts folder, the first script you find is wmenu.sh, this file goes in the top of my vps/dedi accounts as it is used to pull the active screens for that account.
Then you enter the server_pack folder, those scripts are used to further develop or run the server.
Then you enter the mods folder and there are two scripts there and their used to test the server and make reports.

## Notes
there are other scripts located here that are basically artifacts from my various other projects all related to this but for instance when I made server packs that ran on the technic platform.

Further because of the nature of bash and how easy it is to do scripting, the scripts have been known to change from time to adapt to the current circumstance.

I am aware that mkServer.sh could use a massive rewrite and a bit of optimization to work better and look more fluid when read manually. As it stands now it does way too much when I should technically invert what it does and simply archive what is required.


