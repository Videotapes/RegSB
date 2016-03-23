#!/bin/bash
#this does the things

echo "Welcome to the script Stache made; it does the things"

PS3="++++Please select an action: "
select option in unpack swap cleanup kopps quit
#what to say when run

do
		case $option in
			#begin case statement with menu options
			unpack)
			#teal deer: this will set up folders, move and unpack a recently-download register db
			#it can handle multiple dbs, but will start with the most recent download
				echo "Initiating desktop setup for diagnostics."
				if [ -e ~/desktop/cleanuptemp.txt ]
					then
						echo "cleanuptemp.txt already exists; skipping generation."
					else
						echo "Creating cleanuptemp.txt."
						touch ~/desktop/cleanuptemp.txt
				fi
				#prep temp cleanup file for later
				echo "How many registers are you setting up? "

				read -r registers

				until [ "$registers" -le 0 ]
				do
					####diagnostic nonsense begin
					#cat cleanuptemp.txt
					#echo "$registers"
					####diagnostic nonsense end
					echo "Enter the account name: "
					read -r account
					#ask for account name, read into variable

					f1="diags"
					f2="orig"

					f1c=$account$f1
					f2c=$account$f2

					mkdir -v ~/desktop/"$f1c" && mkdir -v ~/desktop/"$f2c"
					#create folders for diags/base activation based on account name

					if [ -s ~/desktop/cleanuptemp.txt ]
						then
							####diagnostic nonsense begin
							#cat cleanuptemp.txt
							#echo "Running then"
							####diagnostic nonsense end
							echo "$f1c" >> cleanuptemp.txt && echo "$f2c" >> cleanuptemp.txt

						else
							####diagnostic nonsense begin
							#cat cleanuptemp.txt
							#echo "Running else"
							####diagnostic nonsense end
							echo "$f1c" > cleanuptemp.txt && echo "$f2c" >> cleanuptemp.txt
					fi
						#check if temp file is empty; store the names of the directories in here for cleanup to reference

					diagnostics=$(ls -t ~/downloads |grep .zip |head -1)

					echo "$diagnostics"

					mv -v ~/downloads/"$diagnostics" ~/desktop/"$f1c"

					cd ~/desktop/"$f1c"

					unzip "$diagnostics"
					((registers--))
					#locate, move and unzip most recently downloaded diags
				done
				;;

			swap)
			#teal deer: this will swap the dbs from the diags with the one pulled from xcode
				echo "This does nothing right now; stop doing it"
				;;

			cleanup)

				echo "Deconstructing desktop setup."

				cd ~/desktop

				#jump to desktop

				while read -r directory
				do
					rm -rfv "$directory"
				done < cleanuptemp.txt

				#iterate through cleanuptemp.txt and kill recorded directories

				rm -rfv cleanuptemp.txt
				;;
				#clean up after cleanup

			kopps)

				echo "Not authorized; this command is Kopps Secret."
				;;

			quit)
				#it does what it says on the tin

				echo "Goodbye."

				break ;;

		esac
		REPLY=
done
